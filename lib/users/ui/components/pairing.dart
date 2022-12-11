import 'package:daisy_too/global/logic/cubit/status_notifier_cubit.dart';
import 'package:daisy_too/types/listeners.dart';
import 'package:daisy_too/users/logic/cubit/pair_edit_cubit.dart';
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
        return BlocProvider.value(
          value: context.read<PairingCubit>(),
          child: BlocProvider(
            create: (context) => PairEditCubit(
              pair: context.read<UsersCubit>().state.pair,
            ),
            child: PairEditListener(
              listenWhen: (_, current) {
                return current.sentPairingResponse;
              },
              listener: (context, state) {
                context.read<UsersCubit>().savePair(pair: state.pair);
                context
                    .read<StatusNotifierCubit>()
                    .showSuccess('You are paired with ${state.pair}!');
                Navigator.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Pairing(),
              ),
            ),
          ),
        );
      },
    );
  }

  static const _pairingRequestStep = 0;
  static const _pairingRequestedStep = 1;

  @override
  Widget build(BuildContext context) {
    final currentStep = _pairingStep(context);
    return Stepper(
      currentStep: currentStep,
      controlsBuilder: _buildControls,
      onStepTapped: (step) {
        if (step == _pairingRequestStep &&
            context.read<PairEditCubit>().state.sentPairingRequest) {
          context.read<PairEditCubit>().clearSentRequest();
        }
      },
      steps: [
        PairWithStep(context,
            state: currentStep == _pairingRequestStep
                ? StepState.editing
                : StepState.complete),
        PairRequestStep(context,
            state: currentStep == _pairingRequestedStep
                ? StepState.editing
                : null),
      ],
    );
  }

  Widget _buildControls(context, detail) {
    return detail.currentStep == _pairingRequestedStep
        ? const IgnorePointer()
        : const RequestPairButton();
  }

  int _pairingStep(BuildContext context) {
    final sentPairingRequest = PairEditCubit.sentPairingRequest(context);
    return sentPairingRequest ? _pairingRequestedStep : _pairingRequestStep;
  }
}

class RequestPairButton extends StatelessWidget {
  const RequestPairButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSendingRequest = context.select((PairEditCubit value) {
      return value.state.sendingPairingRequest;
    });
    const bold = TextStyle(fontWeight: FontWeight.bold);
    return isSendingRequest
        ? const TextButton(
            onPressed: null,
            child: Text('Sending request...', style: bold),
          )
        : TextButton(
            onPressed: () {
              context.read<PairEditCubit>().sendPairingRequest(
                    requestingUsername:
                        context.read<UsersCubit>().state.username,
                  );
            },
            child: const Text('Request pair', style: bold));
  }
}

class _Pair extends StatelessWidget {
  const _Pair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.select((PairEditCubit value) => value.state.pair),
    );
  }
}

class PairRequestStep extends Step {
  const PairRequestStep(
    BuildContext context, {
    StepState? state,
  }) : super(
          state: state ?? StepState.indexed,
          isActive: state == StepState.editing,
          content: const PairingCodeInput(),
          title: const Text('Pairing code'),
        );
}

class PairWithStep extends Step {
  PairWithStep(
    BuildContext context, {
    StepState? state,
  }) : super(
          state: state ?? StepState.indexed,
          isActive: state == StepState.editing,
          content: TextFormField(
            onChanged: context.read<PairEditCubit>().onPairChange,
            initialValue: context.read<PairEditCubit>().state.pair,
          ),
          title: const Text('Pair with'),
          subtitle: const _Pair(),
        );
}
