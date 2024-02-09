import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid/common/route.dart';
import 'package:rfid/modules/register_client/register_client_cubit.dart';

class RegisterClientView extends StatelessWidget {
  const RegisterClientView._();

  static Widget provide() => BlocProvider(
      create: (context) => RegisterClientCubit(context.read(), context.read()),
      lazy: false,
      child: const RegisterClientView._());

  static Route<void> route() => createRoute(provide());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrovanje osoblja'),
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: BlocBuilder<RegisterClientCubit, RegisterClientState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const CircularProgressIndicator();
              }

              if (state.rfid == null) {
                return const Text('Molimo skenirajte novu karticu');
              }

              final ime =
                  context.select((RegisterClientCubit cubit) => cubit.ime);
              final prezime =
                  context.select((RegisterClientCubit cubit) => cubit.prezime);

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('ID kartice je ${state.rfid}'),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: ime,
                    decoration: const InputDecoration(hintText: 'Ime'),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: prezime,
                    decoration: const InputDecoration(hintText: 'Prezime'),
                  ),
                  const SizedBox(height: 16.0),
                  Visibility(
                    // visible: ime.text.trim().isNotEmpty &&
                    //     prezime.text.trim().isNotEmpty,
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<RegisterClientCubit>()
                            .createClient()
                            .then((status) {
                          switch (status) {
                            case ClientCreationStatus.success:
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Uspjesno registrovan ${ime.text} ${prezime.text}'),
                                ),
                              );
                            case ClientCreationStatus.failure:
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Spremanje osoblja nije uspjelo'),
                                ),
                              );
                          }
                        });
                      },
                      child: const Text('Spremi'),
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
}
