import 'dart:async';

import 'package:rfid/data/classes/db_entity.dart';
import 'package:rfid/data/repositories/firebase_repository.dart';
import 'package:rfid/data/repositories/sqlite_repository.dart';
import 'package:rfid/data/sqlite_filter.dart';
import 'package:sqflite/sqlite_api.dart';

enum HookType { firebase, sqlite }

abstract class SyncRepository<T extends DBEntity> {
  SyncRepository({
    required Database db,
    required String tableName,
    required T Function(Map<String, dynamic>) fromMap,
    required String Function(String) tableCreationString,
  })  : _db = db,
        _tableName = tableName,
        _fromMap = fromMap {
    db.execute(tableCreationString(_queueTableName));
  }

  final Database _db;
  final String _tableName;
  final T Function(Map<String, dynamic>) _fromMap;

  late final _firebase = FirebaseRepository(
    collectionName: _tableName,
    fromMap: _fromMap,
  );

  late final _sqlite = SqliteRepository<T>(
    db: _db,
    tableName: _tableName,
    fromMap: _fromMap,
  );

  String get _queueTableName => '${_tableName}queue';
  late final _queue = SqliteRepository<T>(
    db: _db,
    tableName: _queueTableName,
    fromMap: _fromMap,
  );

  Future<T?> get(int id) => _firebase
      .get(id)
      .timeout(const Duration(seconds: 1))
      .catchError((_, __) =>
          _sqlite.get(SqliteFilter.byId(id)).then((rows) => rows.firstOrNull));

  Future<List<T>> getAll() => _firebase
      .getAll()
      .timeout(const Duration(seconds: 1))
      .catchError((_, __) => _sqlite.get(null));

  Future<void> tryEmptyQueue() => _queue.get(null).then((rows) {
        for (final row in rows) {
          _firebase
              .set(row)
              .then<void>((_) => _queue.delete(SqliteFilter.byId(row.id!)))
              .timeout(const Duration(seconds: 5))
              .onError((_, __) => null);
        }
      });

  Future<int> set(T data) => _sqlite
      .set(data)
      .then((id) => _queue.set(_fromMap(data.toMap()..['id'] = id)))
      .then((id) => tryEmptyQueue().then((_) => id));
}
