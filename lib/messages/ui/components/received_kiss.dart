import 'package:daisy_too/messages/logic/cubit/kiss_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceivedKiss extends StatelessWidget {
  const ReceivedKiss({Key? key}) : super(key: key);
  static show(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: context.read<KissCubit>(),
            child: const ReceivedKiss(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO display custom message
    return const AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 120),
      title: _KissHeader(),
      content: Center(
        child: _KissImage(),
      ),
      actions: [_SendKissBackButton()],
    );
  }
}

class _KissHeader extends StatelessWidget {
  const _KissHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kiss = context.select((KissCubit value) => value.state.receivedKiss);
    return Text('You recieved ${kiss!.type}');
  }
}

class _KissImage extends StatelessWidget {
  const _KissImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kiss = context.select((KissCubit value) => value.state.receivedKiss);
    return kiss!.assetPath != null
        ? Image.asset(kiss.assetPath!)
        : const IgnorePointer();
  }
}

class _SendKissBackButton extends StatelessWidget {
  const _SendKissBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => _sendBacc(context),
      icon: const Icon(Icons.favorite),
      label: const Text('Send kiss bacc'),
    );
  }

  _sendBacc(BuildContext context) {
    final kiss = context.read<KissCubit>().state.receivedKiss!;
    context.read<KissCubit>().sendKiss(kiss);
    Navigator.of(context).pop();
  }
}
