import 'dart:async';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/data/repositories/client_repository.dart';
import 'package:rfid/data/repositories/serial_repository.dart';

part 'register_client_cubit.mapper.dart';

@MappableClass()
final class RegisterClientState with RegisterClientStateMappable {
  RegisterClientState(this.rfid, this.isLoading);

  final String? rfid;
  final bool isLoading;
}

enum ClientCreationStatus { success, failure }

final class RegisterClientCubit extends Cubit<RegisterClientState> {
  RegisterClientCubit(SerialRepository serialRepository, this._clientRepository)
      : super(RegisterClientState(null, false)) {
    _subcription = serialRepository.wordStream.listen(updateRfid);
  }

  StreamSubscription? _subcription;
  final ClientRepository _clientRepository;
  final ime = TextEditingController();
  final prezime = TextEditingController();

  void updateRfid(String val) => emit(state.copyWith(rfid: val));

  Future<ClientCreationStatus> createClient() async {
    emit(state.copyWith(isLoading: true));
    return _clientRepository
        .createClient(ime.text.trim(), prezime.text.trim(), state.rfid!)
        .timeout(const Duration(seconds: 5))
        .then((_) => ClientCreationStatus.success)
        .onError((_, __) => ClientCreationStatus.failure)
        .whenComplete(() => emit(state.copyWith(isLoading: false)));
  }

  @override
  Future<void> close() async {
    await _subcription?.cancel();
    return super.close();
  }
}
