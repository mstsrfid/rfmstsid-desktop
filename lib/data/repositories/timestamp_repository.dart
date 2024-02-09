import 'package:rfid/data/classes/client_timestamp/client_timestamp.dart';
import 'package:rfid/data/repositories/sync_repository.dart';
import 'package:sqflite/sqlite_api.dart';

final class TimestampRepository extends SyncRepository<ClientTimestamp> {
  TimestampRepository({
    required Database db,
    required String tableName,
    required super.fromMap,
  }) : super(
          db: db,
          tableName: tableName,
          tableCreationString: ClientTimestamp.createTable,
        ) {
    db.execute(ClientTimestamp.createTable(tableName));
  }

  Future<void> addTimestamp(int clientId) =>
      set(ClientTimestamp(null, clientId, DateTime.now().toUtc()));

  Future<void> rememberAutoincrement() =>
      getMaxFirebaseIndex().then(setAutoIncrementValue);
}
