import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseRepository {
  FirebaseRepository(this.collectionName);

  final _db = FirebaseFirestore.instance;
  final String collectionName;

  CollectionReference<Map<String, dynamic>> get collection =>
      _db.collection(collectionName);
}
