import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/common/route.dart';
import 'package:rfid/data/classes/client/client.dart';
import 'package:rfid/data/repositories/client_repository.dart';
import 'package:rfid/modules/home/serial_cubit.dart';

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
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 64.0),
          child: StreamBuilder(
            stream: context.select(
              (ClientRepository repo) => repo.clientStream,
            ),
            builder: (context, snapshot) {
              context.read<SerialCubit>().setClients(snapshot.data ?? []);

              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              if (snapshot.data!.isEmpty) {
                return const Text('Nema korisnika. Pritisnite f12.');
              }

              return Column(
                children: [
                  BlocBuilder<SerialCubit, Client?>(
                    builder: (context, welcomeer) => Visibility(
                      visible: welcomeer != null,
                      child: Builder(builder: (context) {
                        final msg = welcomeer!.isPresent == 0
                            ? 'Dobrodošao/la'
                            : 'Doviđenja';
                        return Text(
                          '$msg ${welcomeer.ime} ${welcomeer.prezime}',
                          style: const TextStyle(fontSize: 24.0),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Flexible(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 800.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => _buildClient(
                          index,
                          snapshot.data!,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Container _buildClient(int index, List<Client> clients) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 24.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: index == 0
              ? BorderSide.none
              : const BorderSide(color: Colors.grey),
        ),
      ),
      child: Row(
        children: [
          Text(
            '${clients[index].ime} ${clients[index].prezime}',
          ),
          const Spacer(),
          Text(
            clients[index].isPresent == 1 ? 'PRISUTAN' : 'ODSUTAN',
            style: TextStyle(
              color: clients[index].isPresent == 1 ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
