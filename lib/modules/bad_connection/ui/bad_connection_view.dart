import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/common/route.dart';
import 'package:rfid/data/repositories/serial_repository.dart';
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Skener nije konektovan...'),
            const SizedBox(height: 16.0),
            BlocBuilder<BadConnectionCubit, IsLoading>(
              builder: (context, isLoading) {
                if (isLoading) {
                  return const CircularProgressIndicator();
                }

                return ElevatedButton(
                  onPressed: () =>
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      switch (context.read<BadConnectionCubit>().connect()) {
                        SerialConnectionStatus.connected =>
                          'Uspjesno konektovano',
                        SerialConnectionStatus.disconnected =>
                          'Nije uspjela konekcija',
                      },
                    ),
                  )),
                  child: const Text(
                    'Pritisnite ovdje za uspostavu konekcije',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
