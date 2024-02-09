import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/data/classes/client/client.dart';
import 'package:rfid/data/classes/client_timestamp/client_timestamp.dart';
import 'package:rfid/data/repositories/timeout_repository.dart';
import 'package:rfid/data/repositories/timestamp_repository.dart';
import 'package:rfid/modules/bad_connection/bad_connection_view.dart';
import 'package:rfid/modules/home/home_view.dart';
import 'package:rfid/data/repositories/client_repository.dart';
import 'package:rfid/data/repositories/serial_repository.dart';
import 'package:rfid/modules/register_client/register_client_view.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firestore.initialize('msts-rfid');

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
        navigatorKey.currentState?.push(RegisterClientView.route());
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    },
  );

  final db = await openDatabase('rfid.db');

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: serialRepository),
        RepositoryProvider(
          create: (_) => TimestampRepository(
            db: db,
            tableName: 'TIMESTAMPS',
            fromMap: ClientTimestampMapper.fromMap,
          ),
          lazy: false,
        ),
        RepositoryProvider(
          create: (_) => ClientRepository(
            db: db,
            tableName: 'CLIENTS',
            fromMap: ClientMapper.fromMap,
          ),
          lazy: false,
        ),
        RepositoryProvider(
          create: (context) => TimeoutRepository(
            clientRepository: context.read(),
            timestampRepository: context.read(),
          ),
          lazy: false,
        )
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
