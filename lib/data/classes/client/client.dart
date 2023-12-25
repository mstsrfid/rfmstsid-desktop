import 'package:dart_mappable/dart_mappable.dart';
import 'package:rfid/data/repositories/firebase_repository.dart';

part 'client.mapper.dart';

@MappableClass()
final class Client with FirebaseEntity, ClientMappable {
  Client({
    required this.id,
    required this.rfid,
    required this.ime,
    required this.prezime,
    required this.isPresent,
  });

  @override
  final String id;
  final String rfid;
  final String ime;
  final String prezime;
  final bool isPresent;
}
