import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/data/repositories/serial_repository.dart';

enum BadConnectionState { loading, idle }

final class BadConnectionCubit extends Cubit<BadConnectionState> {
  BadConnectionCubit(this._serialRepository) : super(BadConnectionState.idle);

  final SerialRepository _serialRepository;

  Future<SerialConnectionStatus> connect() {
    emit(BadConnectionState.loading);
    return _serialRepository
        .connect()
        .whenComplete(() => emit(BadConnectionState.idle));
  }
}
