import 'package:dart_mappable/dart_mappable.dart';
import 'package:rfid/data/classes/db_entity.dart';

part 'client.mapper.dart';

@MappableClass(ignoreNull: true)
final class Client with DBEntity, ClientMappable {
  Client({
    required this.id,
    required this.rfid,
    required this.ime,
    required this.prezime,
    required this.isPresent,
  });

  @override
  final int? id;
  final String rfid;
  final String ime;
  final String prezime;
  final int isPresent;

  static String createTable(String tableName) =>
      '''CREATE TABLE IF NOT EXISTS $tableName (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  rfid TEXT NOT NULL,
  ime TEXT NOT NULL,
  prezime TEXT NOT NULL,
  isPresent INTEGER NOT NULL
);''';
}
