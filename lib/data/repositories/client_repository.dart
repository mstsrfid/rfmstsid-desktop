import 'dart:async';

import 'package:rfid/data/classes/client/client.dart';
import 'package:rfid/data/repositories/offline_firebase_repository.dart';
import 'package:rfid/data/repositories/timestamp_repository.dart';

final class ClientRepository extends OfflineFirebaseRepository<Client> {
  ClientRepository(super._prefs, this._timestampRepository) {
    collection.stream.listen((data) => _clientStreamController
        .add(data.map((e) => decode(e.map..['id'] = e.id)).toList()));
  }

  @override
  String get collectionName => 'CLIENTS';

  @override
  Client decode(Map<String, dynamic> data) => ClientMapper.fromMap(data);

  @override
  Map<String, dynamic> encode(Client data) => data.toMap();

  @override
  void onConnectionChanged(bool isOffline) {
    if (isOffline) {
      _clientStreamController.add(getAllOffline());
    } else {
      final downstream = getAllOffline();
      getAllMaybeOffline().then((upstream) {
        final correctClients = upstream.indexed.map(
          (e) => e.$2.copyWith(isPresent: downstream[e.$1].isPresent),
        );
        for (final client in correctClients) {
          setMaybeOffline(client);
        }
      });
    }
  }

  final TimestampRepository _timestampRepository;

  final _clientStreamController = StreamController<List<Client>>.broadcast();
  Stream<List<Client>> get clientStream => _clientStreamController.stream;

  Future<void> createClient(String ime, String prezime, String rfid) async {
    final client = Client(
      // TODO use uuid
      id: '',
      rfid: rfid,
      ime: ime,
      prezime: prezime,
      isPresent: false,
    );

    await setMaybeOffline(client);
    await _timestampRepository.setClear(client.copyWith(id: client.id));
  }

  Future<void> setClient(Client client) =>
      setMaybeOffline(client).whenComplete(() {
        if (isOffline) {
          _clientStreamController.add(getAllOffline());
        }
      });
}
