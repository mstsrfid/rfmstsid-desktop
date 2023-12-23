import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/common/route.dart';
import 'package:rfid/data/repositories/client_repository.dart';
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
          child: StreamBuilder(
            stream: context.select(
              (ClientRepository repo) => repo.clientStream,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('NO DATA');
              }

              final clients = snapshot.data!;
              return ListView.builder(
                itemCount: clients.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: [
                      Text(
                        '${clients[index].ime} ${clients[index].prezime}',
                      ),
                      const Spacer(),
                      Text(clients[index].isPresent ? 'PRISUTAN' : 'ODSUTAN'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
