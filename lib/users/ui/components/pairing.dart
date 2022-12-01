import 'package:daisy_too/types/listeners.dart';
import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:daisy_too/users/ui/components/pairing_code_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pairing extends StatelessWidget {
  const Pairing({Key? key}) : super(key: key);

  static asModal(BuildContext context) {
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
            child: Pairing(),
          ),
        );
      },
    );
  }

  static const _pairingRequestStep = 0;
  static const _pairingRequestedStep = 1;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _pairingStep(context),
      controlsBuilder: _buildControls,
      onStepTapped: (step) {
        if (step == _pairingRequestStep &&
            context.read<PairingCubit>().state.sentPairingRequest) {
          context.read<PairingCubit>().clearSentRequest();
        }
      },
      // TODO set active ind
      steps: [
        PairingSteps.pairWith,
        PairingSteps.pairingInput,
      ],
    );
  }

  Widget _buildControls(context, detail) {
    return detail.currentStep == _pairingRequestedStep
        ? const IgnorePointer()
        : const RequestPairButton();
  }

  int _pairingStep(BuildContext context) {
    final sentPairingRequest = context.select((PairingCubit value) {
      return value.state.sentPairingRequest;
    });
    return sentPairingRequest ? _pairingRequestedStep : _pairingRequestStep;
  }
}

class RequestPairButton extends StatelessWidget {
  const RequestPairButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final requestingUsername = context.read<UsersCubit>().state.username;
        context.read<PairingCubit>().sendPairingRequest(
              requestingUsername: requestingUsername,
            );
      },
      child: const Text('Request pair'),
    );
  }
}

class PairingSteps {
  static get pairWith {
    return Step(
      title: const Text('Pair with'),
      content: Builder(
        builder: (context) => TextFormField(
          onChanged: context.read<PairingCubit>().onPairChange,
          initialValue: context.read<UsersCubit>().state.pair,
        ),
      ),
      subtitle: const _Pair(),
    );
  }

  static get pairingInput {
    return const Step(
      title: Text('Pairing code'),
      content: PairingCodeInput(),
    );
  }
}

class _Pair extends StatelessWidget {
  const _Pair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.select((PairingCubit value) => value.state.pair),
    );
  }
}
