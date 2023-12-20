import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/modules/bad_connection/ui/bad_connection_view.dart';
import 'package:rfid/modules/home/ui/home_view.dart';
import 'package:rfid/data/repositories/client_repository.dart';
import 'package:rfid/data/repositories/serial_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final navigatorKey = GlobalKey<NavigatorState>();

  final serialRepository = SerialRepository(
    (status) => navigatorKey.currentState?.pushAndRemoveUntil(
      status == SerialConnectionStatus.connected
          ? HomeView.route()
          : BadConnectionView.route(),
      (_) => false,
    ),
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: serialRepository),
        RepositoryProvider(create: (_) => ClientRepository()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: serialRepository.isConnected
            ? const HomeView()
            : BadConnectionView.provide(),
      ),
    ),
  );
}
