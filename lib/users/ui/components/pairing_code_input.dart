import 'dart:developer';

import 'package:daisy_too/types/listeners.dart';
import 'package:daisy_too/users/logic/cubit/pair_edit_cubit.dart';

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
            PairEditListener(
              listenWhen: (_, current) {
                return current.focusedCellIndex == widget.index &&
                    !focusNode.hasFocus;
              },
              listener: (context, _) {
                focusNode.requestFocus();
                context.read<PairEditCubit>().onCellChange(widget.index);
              },
            ),
            PairEditListener(
              listenWhen: (previous, current) {
                return !previous.codeComplete && current.codeComplete;
              },
              listener: (context, _) {
                _sendPairingResponse(context);
              },
            )
          ],
          child: BlocSelector<PairEditCubit, PairEditState, String>(
            selector: (state) {
              return state.code[widget.index];
            },
            builder: (context, code) {
              return TextFormField(
                textAlign: TextAlign.center,
                focusNode: focusNode,
                initialValue: code,
                onChanged: context.read<PairEditCubit>().onCodeChange,
                onTap: () => context.read<PairEditCubit>().onCellChange(
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
    // TODO fires repeatedly
    log('sent pairing response');
    context.read<PairingCubit>().sendPairingResponse(
          requestingUsername: context.read<UsersCubit>().state.username,
          pairingCode: context.read<PairEditCubit>().state.code.join(''),
          pair: context.read<PairEditCubit>().state.pair,
        );
  }
}
