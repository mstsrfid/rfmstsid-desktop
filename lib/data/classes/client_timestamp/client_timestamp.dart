import 'package:dart_mappable/dart_mappable.dart';
import 'package:rfid/data/classes/db_entity.dart';

part 'client_timestamp.mapper.dart';

final class _Hook extends MappingHook {
  const _Hook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is Map<String, dynamic>) {
      return value
        ..['timestamp'] =
            DateTime.fromMillisecondsSinceEpoch(value['timestamp'] * 1000);
    }
    return null;
  }

  @override
  Object? afterEncode(Object? value) {
    if (value is Map<String, dynamic>) {
      return value
        ..['timestamp'] =
            DateTime.parse(value['timestamp']).millisecondsSinceEpoch ~/ 1000;
    }
    return null;
  }
}

@MappableClass(ignoreNull: true, hook: _Hook())
final class ClientTimestamp with DBEntity, ClientTimestampMappable {
  ClientTimestamp(this.id, this.clientId, this.timestamp);

  @override
  final int? id;
  final int clientId;
  final DateTime timestamp;

  static String createTable(String tableName) =>
      '''CREATE TABLE IF NOT EXISTS $tableName (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  clientId INTEGER NOT NULL,
  timestamp INTEGER NOT NULL
);''';
}
