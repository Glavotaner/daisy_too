import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KissTap extends StatelessWidget {
  const KissTap({required this.onTap, Key? key}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final canMessage = context.select((UsersCubit cubit) {
      return cubit.state.canMessage;
    });
    return IgnorePointer(
      ignoring: !canMessage,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.pink[50]!.withAlpha(175),
        ),
      ),
    );
  }
}
