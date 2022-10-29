import 'package:daisy_too/types/providers.dart';
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
    final _isRegistered = UsersProvider.isRegistered(context);
    return Center(
      child: Column(
        children: [
          _RegistrationStepper(isRegistered: _isRegistered),
          Expanded(
            child: AnimatedOpacity(
              opacity: _isRegistered ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Pairing(isRegistered: _isRegistered),
                  ),
                  if (_isRegistered) const _PairLaterButton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _RegistrationStepper extends StatelessWidget {
  final bool isRegistered;
  const _RegistrationStepper({
    required this.isRegistered,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controlsBuilder: (_, __) {
        return isRegistered
            ? const IgnorePointer()
            : TextButton.icon(
                onPressed: context.read<UsersProvider>().registerUser,
                label: const Text('Register'),
                icon: const Icon(Icons.person),
              );
      },
      steps: [
        Step(
          state: isRegistered ? StepState.complete : StepState.editing,
          title: const Text('Register yourself'),
          content: TextFormField(
            onChanged: context.read<UsersProvider>().onUsernameChange,
            enabled: !isRegistered,
            initialValue: context.read<UsersProvider>().state.username,
          ),
        ),
      ],
    );
  }
}

class _PairLaterButton extends StatelessWidget {
  const _PairLaterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: context.read<UsersProvider>().onboardUser,
      child: const Text('Pair later'),
    );
  }
}
