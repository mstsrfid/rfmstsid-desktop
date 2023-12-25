import 'package:rfid/data/classes/client/client.dart';
import 'package:rfid/data/classes/client_timestamps/client_timestamps.dart';
import 'package:rfid/data/repositories/offline_firebase_repository.dart';

final class TimestampRepository
    extends OfflineFirebaseRepository<ClientTimestamps> {
  TimestampRepository(super._prefs);

  @override
  String get collectionName => 'TIMESTAMPS';

  @override
  ClientTimestamps decode(Map<String, dynamic> data) =>
      ClientTimestampsMapper.fromMap(data
        ..['timestamps'] = (data['timestamps'] as List)
            .cast<int>()
            .map((e) => DateTime.fromMillisecondsSinceEpoch(e))
            .toList());

  @override
  Map<String, dynamic> encode(ClientTimestamps data) => data.toMap()
    ..['timestamps'] =
        data.timestamps.map((e) => e.millisecondsSinceEpoch).toList();

  @override
  void onConnectionChanged(bool isOffline) {
    if (!isOffline) {
      for (final data in getAllOffline()) {
        setMaybeOffline(data);
      }
    }
  }

  Future<void> addTimestamp(Client client) async {
    final now = DateTime.now().toUtc();

    final timestamps =
        ((await getMaybeOffline(client.id)) ?? ClientTimestamps(client.id, []))
            .timestamps
            .toList();
    await setMaybeOffline(ClientTimestamps(client.id, timestamps..add(now)));
  }

  Future<void> setClear(Client client) =>
      setMaybeOffline(ClientTimestamps(client.id, []));
}
