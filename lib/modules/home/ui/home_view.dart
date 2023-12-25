import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/common/route.dart';
import 'package:rfid/data/classes/client/client.dart';
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
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 64.0),
          child: BlocBuilder<SerialCubit, SerialState>(
            builder: (context, state) => Container(
              constraints: const BoxConstraints(maxWidth: 800.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.clients.length,
                itemBuilder: (_, index) => _buildClient(index, state.clients),
              ),
            ),
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
            clients[index].isPresent ? 'PRISUTAN' : 'ODSUTAN',
            style: TextStyle(
              color: clients[index].isPresent ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
