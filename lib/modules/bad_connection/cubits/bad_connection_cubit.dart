import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/data/repositories/serial_repository.dart';

typedef IsLoading = bool;

final class BadConnectionCubit extends Cubit<IsLoading> {
  BadConnectionCubit(this._serialRepository) : super(false);

  final SerialRepository _serialRepository;

  Future<SerialConnectionStatus> connect() {
    emit(true);
    return _serialRepository.connect().whenComplete(() => emit(false));
  }
}
