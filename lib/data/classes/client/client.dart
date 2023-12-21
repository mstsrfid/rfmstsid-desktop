import 'package:dart_mappable/dart_mappable.dart';

part 'client.mapper.dart';

@MappableClass()
final class Client with ClientMappable {
  Client({
    required this.id,
    required this.rfid,
    required this.ime,
    required this.prezime,
    required this.isPresent,
  });

  final String id;
  final String rfid;
  final String ime;
  final String prezime;
  final bool isPresent;
}
