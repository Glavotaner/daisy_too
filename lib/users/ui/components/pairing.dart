import 'package:daisy_too/types/listeners.dart';
import 'package:daisy_too/types/providers.dart';
import 'package:daisy_too/users/ui/components/pairing_code_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pairing extends StatelessWidget {
  final bool isRegistered;
  const Pairing({
    required this.isRegistered,
    Key? key,
  }) : super(key: key);

  static showModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return UsersListener(
          listenWhen: (previous, current) {
            return previous.pair != current.pair;
          },
          listener: (context, state) {
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Pairing(isRegistered: false),
          ),
        );
      },
    );
  }

  static const pairingRequestedStep = 1;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: PairingProvider.pairingRequested(context) ? 1 : 0,
      controlsBuilder: (context, detail) {
        return detail.currentStep == pairingRequestedStep
            ? const IgnorePointer()
            : const _PairingButton();
      },
      steps: [
        Step(
          state: isRegistered ? StepState.editing : StepState.disabled,
          title: const Text('Pair with'),
          content: const _PairInput(),
          subtitle: const _InputtedPair(),
        ),
        Step(
          state: PairingProvider.inputPair(context).isEmpty
              ? StepState.disabled
              : StepState.editing,
          title: const Text('Pairing code'),
          content: const PairingCodeInput(),
        ),
      ],
    );
  }
}

class _PairingButton extends StatelessWidget {
  const _PairingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => context.read<PairingProvider>().sendPairingRequest(
            requestingUsername: context.read<UsersProvider>().state.username,
          ),
      label: const Text('Pair'),
      icon: const Icon(Icons.favorite),
    );
  }
}

class _PairInput extends StatelessWidget {
  const _PairInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: context.read<PairingProvider>().onPairChange,
    );
  }
}

class _InputtedPair extends StatelessWidget {
  const _InputtedPair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(context.select((PairingProvider value) => value.state.pair));
  }
}
