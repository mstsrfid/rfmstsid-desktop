import 'dart:async';

import 'package:rfid/data/repositories/serial_repository.dart';

// This isn't a cubit, but the rules state that logic should be here
final class BadConnectionCubit {
  static Timer? timer;

  BadConnectionCubit(SerialRepository serialRepository) {
    if (timer != null) {
      return;
    }

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (serialRepository.connect() == SerialConnectionStatus.connected) {
        timer!.cancel();
        timer = null;
      }
    });
  }
}
