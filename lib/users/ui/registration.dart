import 'package:daisy_too/types/listeners.dart';
import 'package:daisy_too/users/logic/cubit/pair_edit_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:daisy_too/users/ui/components/pairing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Registration extends StatelessWidget {
  const Registration({
    Key? key,
  }) : super(key: key);

  static page() {
    const route = 'registration';
    return const MaterialPage(
      child: Registration(),
      key: ValueKey(route),
      name: route,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PairEditCubit(),
      child: MultiBlocListener(
        listeners: [
          UsersListener(
            listenWhen: (_, current) => current.hasPair,
            listener: (context, _) {
              context.read<UsersCubit>().onboardUser();
            },
          ),
          PairEditListener(
            listenWhen: (_, current) => current.sentPairingResponse,
            listener: (context, state) {
              context.read<UsersCubit>().savePair(pair: state.pair);
            },
          )
        ],
        child: Column(
          children: const [
            _RegistrationStepper(),
            _PairLaterButton(),
          ],
        ),
      ),
    );
  }
}

class _PairLaterButton extends StatelessWidget {
  const _PairLaterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: context.read<UsersCubit>().onboardUser,
      child: const Text('Pair later'),
    );
  }
}

class _RegistrationStepper extends StatelessWidget {
  const _RegistrationStepper({Key? key}) : super(key: key);

  static const _registrationStep = 0;
  static const _pairingRequestStep = 1;
  static const _pairingRequestedStep = 2;

  @override
  Widget build(BuildContext context) {
    final currentStep = _getRegistrationStep(context);
    StepState? registrationState;
    StepState? pairWithState;
    StepState? pairRequestState;
    switch (currentStep) {
      case _registrationStep:
        registrationState = StepState.editing;
        break;
      case _pairingRequestStep:
        pairWithState = StepState.editing;
        break;
      case _pairingRequestedStep:
        {
          pairWithState = StepState.complete;
          pairRequestState = StepState.editing;
        }
        break;
    }
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
        _RegistrationStep(context, state: registrationState),
        PairWithStep(context, state: pairWithState),
        PairRequestStep(context, state: pairRequestState),
      ],
    );
  }

  Widget _buildControls(context, control) {
    switch (control.currentStep) {
      case _registrationStep:
        return const _RegisterButton();
      case _pairingRequestStep:
        return const RequestPairButton();
      default:
        return const IgnorePointer();
    }
  }

  int _getRegistrationStep(BuildContext context) {
    final sentPairingRequest = PairEditCubit.sentPairingRequest(context);
    final isRegistered = context.select((UsersCubit value) {
      return value.state.isRegistered;
    });
    return sentPairingRequest
        ? _pairingRequestedStep
        : isRegistered
            ? _pairingRequestStep
            : _registrationStep;
  }
}

class _RegistrationStep extends Step {
  _RegistrationStep(BuildContext context, {StepState? state})
      : super(
          state: state ?? StepState.complete,
          isActive: state == StepState.editing,
          title: const Text('Register yourself'),
          subtitle: const _Username(),
          content: TextFormField(
            onChanged: context.read<UsersCubit>().onUsernameChange,
            initialValue: context.read<UsersCubit>().state.username,
          ),
        );
}

class _Username extends StatelessWidget {
  const _Username({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(context.select((UsersCubit value) {
      return value.state.username;
    }));
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isRegistering = context.select((UsersCubit value) {
      return value.state.isRegistering;
    });
    return isRegistering
        ? const TextButton(
            onPressed: null,
            child: Text(
              'Registering..',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : TextButton(
            onPressed: context.read<UsersCubit>().registerUser,
            child: const Text(
              'Register',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
