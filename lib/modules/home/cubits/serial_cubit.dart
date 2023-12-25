import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/data/classes/client/client.dart';
import 'package:rfid/data/repositories/client_repository.dart';
import 'package:rfid/data/repositories/serial_repository.dart';
import 'package:rfid/data/repositories/timestamp_repository.dart';

final class SerialState {
  SerialState(this.clients);

  final List<Client> clients;
}

final class SerialCubit extends Cubit<SerialState> {
  SerialCubit(
    SerialRepository serialRepository,
    ClientRepository clientRepository,
    TimestampRepository timestampRepository,
  ) : super(SerialState([])) {
    _clientSubscription = clientRepository.clientStream
        .listen((clients) => emit(SerialState(clients)));

    bool locked = false;
    _serialSubscription = serialRepository.wordStream.listen((rfid) async {
      if (locked) {
        return;
      }
      locked = true;

      final client = state.clients
          .cast<Client?>()
          .firstWhere((e) => e!.rfid == rfid, orElse: () => null);

      if (client == null) {
        serialRepository.sendBAD();
        Future.delayed(const Duration(seconds: 2)).then((_) => locked = false);
        return;
      }

      // TODO IF A BUG APPEARS, AWAIT THESE TWO FUNCTIONS
      clientRepository.setClient(client.copyWith(isPresent: !client.isPresent));
      timestampRepository.addTimestamp(client);

      serialRepository.sendOK();
      Future.delayed(const Duration(seconds: 2)).then((_) => locked = false);
    });
  }

  StreamSubscription? _clientSubscription;
  StreamSubscription? _serialSubscription;

  @override
  Future<void> close() async {
    await _clientSubscription?.cancel();
    await _serialSubscription?.cancel();
    return super.close();
  }
}
