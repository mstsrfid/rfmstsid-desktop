import 'package:cloud_firestore/cloud_firestore.dart';

mixin FirebaseRepository {
  final _db = FirebaseFirestore.instance;

  String get collectionName;

  CollectionReference<Map<String, dynamic>> get collection =>
      _db.collection(collectionName);
}
