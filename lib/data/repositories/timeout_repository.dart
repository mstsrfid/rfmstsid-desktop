import 'dart:async';

import 'package:rfid/data/repositories/client_repository.dart';
import 'package:rfid/data/repositories/timestamp_repository.dart';

final class TimeoutRepository {
  TimeoutRepository({
    required ClientRepository clientRepository,
    required TimestampRepository timestampRepository,
  }) {
    clientRepository.resyncNames();
    Timer.periodic(const Duration(hours: 1), (_) {
      clientRepository.resyncNames();

      final now = DateTime.now();
      if (now.hour > 19) {
        clientRepository.getAll().then((clients) {
          for (final client in clients) {
            if (client.isPresent == 1) {
              clientRepository
                  .setClient(client.copyWith(isPresent: 1 - client.isPresent));
              timestampRepository.addTimestamp(client.id!);
            }
          }
        });
      }
    });
  }
}
