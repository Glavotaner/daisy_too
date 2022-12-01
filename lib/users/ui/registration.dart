import 'package:daisy_too/types/listeners.dart';
import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:daisy_too/users/ui/components/pairing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Registration extends StatelessWidget {
  const Registration({
    Key? key,
  }) : super(key: key);

  static registration() {
    const route = 'registration';
    return const MaterialPage(
      child: Registration(),
      key: ValueKey(route),
      name: route,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        UsersListener(
          listenWhen: (previous, current) {
            return current.hasPair;
          },
          listener: (context, _) {
            context.read<UsersCubit>().onboardUser();
          },
        ),
      ],
      child: Column(
        children: const [
          _RegistrationStepper(),
          _PairLaterButton(),
        ],
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
    return Stepper(
      currentStep: _getRegistrationStep(context),
      controlsBuilder: _buildControls,
      onStepTapped: (step) {
        if (step == _pairingRequestStep &&
            context.read<PairingCubit>().state.sentPairingRequest) {
          context.read<PairingCubit>().clearSentRequest();
        }
      },
      steps: [
        Step(
          title: const Text('Register yourself'),
          subtitle: const _Username(),
          content: TextFormField(
            onChanged: context.read<UsersCubit>().onUsernameChange,
            initialValue: context.read<UsersCubit>().state.username,
          ),
        ),
        PairingSteps.pairWith,
        PairingSteps.pairingInput,
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
    final selectedPair = context.select((UsersCubit value) {
      return value.state.pair;
    });
    if (selectedPair.isNotEmpty) {
      return _pairingRequestedStep;
    } else {
      final isRegistered = context.select((UsersCubit value) {
        return value.state.isRegistered;
      });
      return isRegistered ? _pairingRequestStep : _registrationStep;
    }
  }
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
    return TextButton(
      onPressed: context.read<UsersCubit>().registerUser,
      child: const Text('Register'),
    );
  }
}
