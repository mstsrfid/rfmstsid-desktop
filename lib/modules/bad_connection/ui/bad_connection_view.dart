import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/common/route.dart';
import 'package:rfid/modules/bad_connection/cubits/bad_connection_cubit.dart';

class BadConnectionView extends StatelessWidget {
  const BadConnectionView._();

  static Widget provide() => RepositoryProvider(
        create: (context) => BadConnectionCubit(context.read()),
        lazy: false,
        child: const BadConnectionView._(),
      );

  static Route<void> route() => createRoute(provide());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Scanner not connected...')),
    );
  }
}
