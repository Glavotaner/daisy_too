import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarPairingButton extends StatelessWidget {
  const AppBarPairingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isOnboarded = context.select((UsersCubit cubit) {
      return cubit.state.isOnboarded;
    });
    return isOnboarded
        ? TextButton.icon(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: context.read<PairingCubit>().requestPair,
            icon: const Icon(Icons.favorite),
            label: const Text('Pair'),
          )
        : const IgnorePointer(ignoring: true);
  }
}
