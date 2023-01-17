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
        child: PairingListener(
          listenWhen: (_, current) => current.receivedPairingResponse != null,
          listener: (context, _) {
            Navigator.of(context).pop();
          },
          child: const ReceivedPairingRequest(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pairingRequest =
        context.read<PairingCubit>().state.receivedPairingRequest!;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: RichText(
                  text: TextSpan(
                text: 'Pair with ',
                children: [
                  TextSpan(
                    text: pairingRequest.requestingUsername,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18),
              )),
            ),
            TextButton.icon(
              onPressed: () => context.read<PairingCubit>().copyPairingCode(),
              label: const _PairingCode(),
              icon: const Icon(Icons.note_alt),
            ),
          ],
        ),
      ),
    );
  }
}

class _PairingCode extends StatelessWidget {
  const _PairingCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.select((PairingCubit value) {
        return value.state.receivedPairingRequest!.pairingCode;
      }),
      style: const TextStyle(fontSize: 24),
    );
  }
}
