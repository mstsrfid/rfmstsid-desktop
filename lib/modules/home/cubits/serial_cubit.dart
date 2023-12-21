import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/data/classes/client/client.dart';
import 'package:rfid/data/repositories/client_repository.dart';
import 'package:rfid/data/repositories/serial_repository.dart';
import 'package:rfid/data/repositories/timestamp_repository.dart';

// TODO what is this?
final class SerialState {}

final class SerialCubit extends Cubit<SerialState> {
  SerialCubit(
    SerialRepository serialRepository,
    ClientRepository clientRepository,
    TimestampRepository timestampRepository,
  ) : super(SerialState()) {
    bool locked = false;
    _subscription = serialRepository.wordStream.listen((rfid) async {
      if (locked) {
        return;
      }
      locked = true;

      final client = (await clientRepository.getClients())
          .cast<Client?>()
          .firstWhere((e) => e!.rfid == rfid, orElse: () => null);

      if (client == null) {
        serialRepository.sendBAD();
        Future.delayed(const Duration(seconds: 2)).then((_) => locked = false);
        return;
      }

      clientRepository.setClient(client.copyWith(isPresent: !client.isPresent));
      await timestampRepository.addTimestamp(client);

      serialRepository.sendOK();
      Future.delayed(const Duration(seconds: 2)).then((_) => locked = false);
    });
  }

  StreamSubscription? _subscription;

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
