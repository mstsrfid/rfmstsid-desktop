import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/data/classes/client/client.dart';
import 'package:rfid/data/repositories/client_repository.dart';
import 'package:rfid/data/repositories/serial_repository.dart';
import 'package:rfid/data/repositories/timestamp_repository.dart';

typedef _Welcomeer = Client?;

final class SerialCubit extends Cubit<_Welcomeer> {
  SerialCubit(
    SerialRepository serialRepository,
    ClientRepository clientRepository,
    TimestampRepository timestampRepository,
  ) : super(null) {
    Timer? timer;
    bool locked = false;
    _serialSubscription = serialRepository.wordStream.listen((rfid) async {
      if (locked) {
        return;
      }
      locked = true;

      final client = _clients
          .cast<Client?>()
          .firstWhere((e) => e!.rfid == rfid, orElse: () => null);

      if (client == null) {
        serialRepository.sendBAD();
        Future.delayed(const Duration(seconds: 2)).then((_) => locked = false);
        return;
      }

      clientRepository
          .setClient(client.copyWith(isPresent: 1 - client.isPresent));
      timestampRepository.addTimestamp(client.id!);

      emit(client);
      if (timer != null) {
        timer?.cancel();
        timer = null;
      }
      timer = Timer(const Duration(seconds: 2), () {
        emit(null);
        timer = null;
      });

      serialRepository.sendOK();
      Future.delayed(const Duration(seconds: 2)).then((_) => locked = false);
    });
  }

  StreamSubscription? _clientSubscription;
  StreamSubscription? _serialSubscription;

  final _clients = <Client>[];

  void setClients(List<Client> clients) => _clients
    ..clear()
    ..addAll(clients);

  @override
  Future<void> close() async {
    await _clientSubscription?.cancel();
    await _serialSubscription?.cancel();
    return super.close();
  }
}
