import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PairingButton extends StatelessWidget {
  const PairingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UsersCubit.isOnboarded(context)
        ? TextButton.icon(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: context.read<PairingCubit>().requestPairing,
            icon: const Icon(Icons.favorite),
            label: const Text('Pair'),
          )
        : const IgnorePointer(ignoring: true);
  }
}
