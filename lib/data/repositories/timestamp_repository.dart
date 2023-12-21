import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rfid/data/classes/client/client.dart';
import 'package:rfid/data/repositories/firebase_repository.dart';

final class TimestampRepository with FirebaseRepository {
  @override
  String get collectionName => 'TIMESTAMPS';

  Future<List<DateTime>> getTimestamps(Client client) => collection
      .doc(client.id)
      .get()
      .then((data) => (data.data()!['timestamps'] as List).cast<Timestamp>())
      .then((data) => data.map((e) => e.toDate().toUtc()).toList());

  Future<void> addTimestamp(Client client) async {
    final timestamps = await getTimestamps(client);
    timestamps.add(DateTime.now().toUtc());
    return collection.doc(client.id).set({'timestamps': timestamps});
  }

  Future<void> setClear(Client client) =>
      collection.doc(client.id).set({'timestamps': []});
}
