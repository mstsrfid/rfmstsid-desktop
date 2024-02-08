import 'package:rfid/data/classes/db_entity.dart';
import 'package:rfid/data/sqlite_filter.dart';
import 'package:sqflite/sqflite.dart';

class SqliteRepository<T extends DBEntity> {
  SqliteRepository({
    required Database db,
    required String tableName,
    required T Function(Map<String, dynamic>) fromMap,
  })  : _fromMap = fromMap,
        _tableName = tableName,
        _db = db;

  final Database _db;
  final String _tableName;
  final T Function(Map<String, dynamic>) _fromMap;

  Future<List<T>> get(SqliteFilter? filter) => _db
      .query(_tableName, where: filter?.text, whereArgs: filter?.args)
      .then((rows) => rows.map((e) => _fromMap(Map.from(e))).toList());

  /// Inserts/Updates a row in the table. Returns row id.
  Future<int> set(T data) => _db.insert(_tableName, data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);

  /// Deletes rows specified by filter.
  /// WARNING: if filter is null, everything will be deleted.
  /// Returns the number of rows affected.
  Future<int> delete(SqliteFilter? filter) =>
      _db.delete(_tableName, where: filter?.text, whereArgs: filter?.args);
}
