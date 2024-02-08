import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import 'package:rfid/data/classes/db_entity.dart';

class FirebaseRepository<T extends DBEntity> {
  FirebaseRepository(
      {required String collectionName,
      required T Function(Map<String, dynamic>) fromMap})
      : _fromMap = fromMap,
        _collectionName = collectionName;

  final String _collectionName;
  final T Function(Map<String, dynamic>) _fromMap;

  final _db = Firestore.instance;
  CollectionReference get _collection => _db.collection(_collectionName);

  Future<T?> get(int id) => _collection
      .document(id.toString())
      .get()
      .then((result) => result.map)
      .then((data) =>
          data.isEmpty ? null : _fromMap(data..['id'] = id.toString()));

  Future<List<T>> getAll() => _collection.get().then((value) =>
      value.map((e) => _fromMap(e.map..['id'] = int.parse(e.id))).toList());

  Future<void> set(T data) =>
      _collection.document(data.id!.toString()).set(data.toMap()..remove('id'));
}
