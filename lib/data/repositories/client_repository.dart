import 'dart:async';

import 'package:rfid/data/classes/client/client.dart';
import 'package:rfid/data/repositories/sync_repository.dart';
import 'package:sqflite/sqlite_api.dart';

final class ClientRepository extends SyncRepository<Client> {
  ClientRepository({
    required Database db,
    required String tableName,
    required super.fromMap,
  }) : super(
          db: db,
          tableName: tableName,
          tableCreationString: Client.createTable,
        ) {
    db.execute(Client.createTable(tableName));

    getAll().then((clients) => _clientStreamController.add(clients));
  }

  final _clientStreamController = StreamController<List<Client>>();
  Stream<List<Client>> get clientStream => _clientStreamController.stream;

  Future<void> createClient(String ime, String prezime, String rfid) => set(
          Client(
              id: null, rfid: rfid, ime: ime, prezime: prezime, isPresent: 0))
      .then((_) =>
          getAllLocal().then((value) => _clientStreamController.add(value)));

  Future<void> setClient(Client client) => set(client).whenComplete(
      () => getAllLocal().then((value) => _clientStreamController.add(value)));

  Future<void> resyncNames() async {
    if (await isQueueEmpty()) {
      return getAll().then((clients) {
        for (final client in clients) {
          set(client);
        }
      });
    }
  }
}
