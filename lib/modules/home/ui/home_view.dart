import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/common/route.dart';
import 'package:rfid/data/repositories/serial_repository.dart';
import 'package:rfid/modules/home/cubits/serial_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView._();

  static Widget provide() => BlocProvider(
        create: (context) => SerialCubit(
          context.read(),
          context.read(),
          context.read(),
        ),
        lazy: false,
        child: const HomeView._(),
      );

  static Route<void> route() => createRoute(provide());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => context.read<SerialRepository>().sendOK(),
                child: const Text(
                  'SEND OK',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () => context.read<SerialRepository>().sendBAD(),
                child: const Text(
                  'SEND BAD',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(height: 16.0),
              StreamBuilder(
                stream:
                    context.select((SerialRepository repo) => repo.wordStream),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('null');
                  }
                  return Text(snapshot.data!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
