import 'dart:async';

import 'package:daisy_too/global/logic/cubit/status_notifier_cubit.dart';
import 'package:daisy_too/main.dart';
import 'package:daisy_too/messages/logic/cubit/kiss_cubit.dart';
import 'package:daisy_too/messages/ui/components/kiss_pages_library.dart';
import 'package:daisy_too/types/listeners.dart';
import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';

import 'package:daisy_too/users/ui/components/pairing.dart';
import 'package:daisy_too/users/ui/components/received_pairing_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'components/swipe_hint.dart';
part 'components/pages_stack.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);
  static page() {
    const route = 'messages';
    return const MaterialPage(
      child: MessagesPage(),
      key: ValueKey(route),
      name: route,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KissCubit(),
      child: MultiBlocListener(
        listeners: [
          ..._PairingListeners().listeners,
          ..._KissListeners().listeners,
        ],
        child: const PagesStack(),
      ),
    );
  }
}

class _PairingListeners {
  List<PairingListener> get listeners => [
        pairingRequestReceived,
        pairingRequested,
      ];

  final pairingRequestReceived = PairingListener(
    listenWhen: (previous, current) {
      final previousRequest = previous.receivedPairingRequest;
      final currentRequest = current.receivedPairingRequest;
      return currentRequest != null && currentRequest != previousRequest;
    },
    listener: (context, state) async {
      final provider = context.read<PairingCubit>();
      await ReceivedPairingRequest.asModal(context);
      Timer(const Duration(milliseconds: 500), provider.clearMessages);
    },
  );

  final pairingRequested = PairingListener(
    listenWhen: (previous, current) {
      return !previous.pairingRequested && current.pairingRequested;
    },
    listener: (context, state) async {
      final provider = context.read<PairingCubit>();
      await Pairing.asModal(context);
      provider.clearRequestedPairing();
    },
  );
}

class _KissListeners {
  List<KissListener> get listeners => [sentListener, receivedListener];

  final sentListener = KissListener(
    listenWhen: (previous, current) {
      return previous.sentKiss != current.sentKiss;
    },
    listener: (context, state) {
      final message = state.sentKiss!.type + ' sented!';
      context.read<StatusNotifierCubit>().showSuccess(message);
    },
  );

  final receivedListener = KissListener(
    listenWhen: (previous, current) {
      return previous.receivedKiss != current.receivedKiss;
    },
    listener: (context, state) {
      final message = state.receivedKiss!.type + ' received!';
      context.read<StatusNotifierCubit>().showSuccess(message);
    },
  );
}
