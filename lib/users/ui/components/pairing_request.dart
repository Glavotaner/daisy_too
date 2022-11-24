import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PairingRequest extends StatelessWidget {
  const PairingRequest({Key? key}) : super(key: key);
  static showModal(BuildContext context) {
    return showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 200),
      context: context,
      builder: (_) => const PairingRequest(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _PairingCode(),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextButton.icon(
              onPressed: context.read<PairingCubit>().copyPairingCode,
              label: const Text('Copy code'),
              icon: const Icon(Icons.note_alt),
            ),
          ),
        ],
      ),
    );
  }
}

class _PairingCode extends StatelessWidget {
  const _PairingCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      PairingCubit.pairingCode(context),
      style: const TextStyle(fontSize: 24),
    );
  }
}
