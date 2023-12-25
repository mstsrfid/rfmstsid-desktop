import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';

mixin FirebaseEntity {
  String get id;
}

mixin FirebaseRepository<T extends FirebaseEntity> {
  final _db = Firestore.instance;

  String get collectionName;

  CollectionReference get collection => _db.collection(collectionName);

  T decode(Map<String, dynamic> data);
  Map<String, dynamic> encode(T data);

  Future<T?> get(String id) => collection
      .document(id)
      .get()
      .then((result) => result.map)
      .then((data) => data == null ? null : decode(data..['id'] = id));

  Future<List<T>> getAll() => collection
      .get()
      .then((value) => value.map((e) => decode(e.map..['id'] = e.id)).toList());

  Future<void> set(T data) =>
      collection.document(data.id).set(encode(data)..remove('id'));
}
