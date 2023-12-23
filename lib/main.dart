import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/data/repositories/timestamp_repository.dart';
import 'package:rfid/modules/bad_connection/ui/bad_connection_view.dart';
import 'package:rfid/modules/home/ui/home_view.dart';
import 'package:rfid/data/repositories/client_repository.dart';
import 'package:rfid/data/repositories/serial_repository.dart';
import 'package:rfid/modules/register_client/ui/register_client_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAR57Vx1hMSs3FnhxKU4gwhA2_hBKRkohg',
      appId: '1:842097774149:web:98becdd9c5272245569d2c',
      messagingSenderId: '842097774149',
      projectId: 'msts-rfid',
      authDomain: 'msts-rfid.firebaseapp.com',
      databaseURL:
          'https://msts-rfid-default-rtdb.europe-west1.firebasedatabase.app',
      storageBucket: 'msts-rfid.appspot.com',
    ),
  );

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
          home: BadConnectionView.provide(),
        ),
      ),
    ),
  );
}
