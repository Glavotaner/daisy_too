import 'package:daisy_too/users/logic/cubit/pair_edit_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        : TextButton.icon(
            onPressed: () {
              context.read<PairEditCubit>().sendPairingRequest(
                requestingUsername: context.read<UsersCubit>().state.username,
              );
            },
            label: const Text('Request pair', style: bold),
            icon: const Icon(Icons.favorite),
          );
  }
}
