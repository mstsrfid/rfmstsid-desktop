import 'package:rfid/data/classes/client/client.dart';
import 'package:rfid/data/repositories/timestamp_repository.dart';
import 'package:rfid/data/repositories/firebase_repository.dart';

final class ClientRepository with FirebaseRepository {
  ClientRepository(this._timestampRepository);

  @override
  String get collectionName => 'CLIENTS';

  final TimestampRepository _timestampRepository;

  Future<List<Client>> getClients() => collection.get().then((data) => data.docs
      .map((e) => ClientMapper.fromMap(e.data()..['id'] = e.id))
      .toList());

  Future<void> createClient(String ime, String prezime, String rfid) async {
    final client = Client(
      id: '',
      rfid: rfid,
      ime: ime,
      prezime: prezime,
      isPresent: false,
    );
    final doc = collection.doc();
    await doc.set(client.toMap()..remove('id'));
    await _timestampRepository.setClear(client.copyWith(id: doc.id));
  }

  Future<void> setClient(Client client) async =>
      collection.doc(client.id).set(client.toMap()..remove('id'));
}
