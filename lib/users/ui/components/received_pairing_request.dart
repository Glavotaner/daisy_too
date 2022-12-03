import 'package:daisy_too/types/listeners.dart';
import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceivedPairingRequest extends StatelessWidget {
  const ReceivedPairingRequest({Key? key}) : super(key: key);
  static asModal(BuildContext context) {
    return showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 200),
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<PairingCubit>(),
        // TODO doesn't work
        child: PairingListener(
          listenWhen: (_, current) => current.receivedPairingResponse != null,
          listener: (context, state) {
            Navigator.of(context).pop();
          },
          child: const ReceivedPairingRequest(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class _PairingCode extends StatelessWidget {
  const _PairingCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.select((PairingCubit value) {
        return value.state.receivedPairingRequest!.data!.pairingCode!;
      }),
      style: const TextStyle(fontSize: 24),
    );
  }
}
