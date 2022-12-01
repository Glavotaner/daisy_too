import 'package:daisy_too/users/logic/cubit/pair_edit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceivedPairingRequest extends StatelessWidget {
  const ReceivedPairingRequest({Key? key}) : super(key: key);
  static asModal(BuildContext context) {
    return showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 200),
      context: context,
      builder: (_) => const ReceivedPairingRequest(),
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
              onPressed: context.read<PairEditCubit>().copyPairingCode,
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
      context.select((PairEditCubit cubit) => cubit.state.code.join('')),
      style: const TextStyle(fontSize: 24),
    );
  }
}
