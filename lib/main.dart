import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/modules/home/ui/home_view.dart';
import 'package:rfid/repositories/client_repository.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (_) => ClientRepository())],
      child: const MaterialApp(home: HomeView()),
    ),
  );
}
