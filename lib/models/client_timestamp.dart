import 'package:dart_mappable/dart_mappable.dart';

part 'client_timestamp.mapper.dart';

@MappableClass()
final class ClientTimestamp with ClientTimestampMappable {
  ClientTimestamp({required this.rfid, required this.timestamps});

  final String rfid;
  final List<DateTime> timestamps;
}
