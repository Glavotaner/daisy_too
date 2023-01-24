import 'package:daisy_too/types/listeners.dart';
import 'package:daisy_too/users/logic/cubit/pair_edit_cubit.dart';

import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PairingCodeInput extends StatelessWidget {
  const PairingCodeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PairEditListener(
      listenWhen: (previous, current) {
        return !previous.codeComplete && current.codeComplete;
      },
      listener: (context, _) {
        context.read<PairEditCubit>().sendPairingResponse(
          requestingUsername: context.read<UsersCubit>().state.username,
        );
      },
      child: Row(
        children: List.generate(6, _PairingCodeInputCell.new),
      ),
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
        child: PairEditListener(
            listenWhen: (_, current) {
              return current.focusedCellIndex == widget.index &&
                  !focusNode.hasFocus;
            },
            listener: (context, _) {
              focusNode.requestFocus();
              context.read<PairEditCubit>().onCellChange(widget.index);
            },
            child: _PairingCodeCell(focusNode: focusNode, index: widget.index)),
      ),
    );
  }
}

class _PairingCodeCell extends StatelessWidget {
  const _PairingCodeCell({
    Key? key,
    required this.focusNode,
    required this.index,
  }) : super(key: key);

  final int index;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final code = context.select((PairEditCubit value) {
      value.state.code[index];
    });
    return TextFormField(
      textAlign: TextAlign.center,
      initialValue: code,
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      onChanged: context.read<PairEditCubit>().onCodeChange,
      onTap: () => context.read<PairEditCubit>().onCellChange(index),
    );
  }
}
