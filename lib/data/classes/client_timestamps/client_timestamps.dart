import 'package:dart_mappable/dart_mappable.dart';
import 'package:rfid/data/repositories/firebase_repository.dart';

part 'client_timestamps.mapper.dart';

@MappableClass()
final class ClientTimestamps with FirebaseEntity, ClientTimestampsMappable {
  ClientTimestamps(this.id, this.timestamps);

  @override
  final String id;
  final List<DateTime> timestamps;
}
