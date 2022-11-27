import 'package:daisy_too/types/listeners.dart';

import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PairingCodeInput extends StatelessWidget {
  const PairingCodeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(6, _PairingCodeInputCell.new),
    );
  }
}

class _PairingCodeInputCell extends StatefulWidget {
  final int index;
  const _PairingCodeInputCell(
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  State<_PairingCodeInputCell> createState() => _PairingCodeInputCellState();
}

class _PairingCodeInputCellState extends State<_PairingCodeInputCell> {
  final focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: MultiBlocListener(
          listeners: [
            PairingListener(
              listenWhen: (_, current) {
                return current.focusedCellIndex == widget.index &&
                    !focusNode.hasFocus;
              },
              listener: (context, _) {
                focusNode.requestFocus();
                context.read<PairingCubit>().onCellChange(widget.index);
              },
            ),
            PairingListener(
              listenWhen: (_, current) {
                return current.codeComplete;
              },
              listener: (context, _) {
                _sendPairingResponse(context);
              },
            )
          ],
          child: BlocSelector<PairingCubit, PairingState, String>(
            selector: (state) {
              return state.code[widget.index];
            },
            builder: (context, code) {
              return TextFormField(
                textAlign: TextAlign.center,
                focusNode: focusNode,
                initialValue: code,
                onChanged: context.read<PairingCubit>().onCodeChange,
                onTap: () => context.read<PairingCubit>().onCellChange(
                      widget.index,
                    ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _sendPairingResponse(BuildContext context) {
    final requestingUsername = context.read<UsersCubit>().state.username;
    context.read<PairingCubit>().sendPairingResponse(
          requestingUsername: requestingUsername,
        );
  }
}
