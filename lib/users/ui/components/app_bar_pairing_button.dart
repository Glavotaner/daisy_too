import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarPairingButton extends StatelessWidget {
  const AppBarPairingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isOnboarded = UsersCubit.isOnboarded(context);
    return isOnboarded
        ? const _PairButton()
        : const IgnorePointer(ignoring: true);
  }
}

class _PairButton extends StatelessWidget {
  const _PairButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO loading
    final hasPair = context.select((UsersCubit value) => value.state.hasPair);
    return TextButton.icon(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(
          hasPair ? Colors.redAccent : Colors.white,
        ),
      ),
      onPressed: context.read<PairingCubit>().requestPair,
      icon: const Icon(Icons.favorite),
      label: const Text('Pair'),
    );
  }
}
