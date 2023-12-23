import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/data/repositories/timestamp_repository.dart';
import 'package:rfid/firebase_options.dart';
import 'package:rfid/modules/bad_connection/ui/bad_connection_view.dart';
import 'package:rfid/modules/home/ui/home_view.dart';
import 'package:rfid/data/repositories/client_repository.dart';
import 'package:rfid/data/repositories/serial_repository.dart';
import 'package:rfid/modules/register_client/ui/register_client_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final navigatorKey = GlobalKey<NavigatorState>();

  final serialRepository = SerialRepository(
    (status) => navigatorKey.currentState?.pushAndRemoveUntil(
      status == SerialConnectionStatus.connected
          ? HomeView.route()
          : BadConnectionView.route(),
      (_) => false,
    ),
  );

  final focusNode = FocusNode(
    onKey: (node, event) {
      if (event.isKeyPressed(LogicalKeyboardKey.f12)) {
        navigatorKey.currentState?.pushAndRemoveUntil(
          RegisterClientView.route(),
          (_) => false,
        );
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    },
  );

  final db = FirebaseFirestore.instance;
  db.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
        db.enableNetwork();
      case ConnectivityResult.none:
        db.disableNetwork();
      default:
        break;
    }
  });

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: serialRepository),
        RepositoryProvider(create: (_) => TimestampRepository()),
        RepositoryProvider(
          create: (context) => ClientRepository(context.read()),
        ),
      ],
      child: Focus(
        focusNode: focusNode,
        child: MaterialApp(
          navigatorKey: navigatorKey,
          home: serialRepository.isConnected
              ? HomeView.provide()
              : BadConnectionView.provide(),
        ),
      ),
    ),
  );
}
