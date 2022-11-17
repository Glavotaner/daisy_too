import 'package:daisy_too/global/logic/cubit/status_notifier_cubit.dart';
import 'package:daisy_too/messages/ui/components/kiss_pages_library.dart';
import 'package:daisy_too/types/listeners.dart';
import 'package:daisy_too/types/providers.dart';
import 'package:daisy_too/users/ui/components/pairing.dart';
import 'package:daisy_too/users/ui/components/pairing_request.dart';
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
      create: (context) => KissProvider(),
      child: MultiBlocListener(
        listeners: [
          ..._PairingListeners().listeners,
          ..._MessagesListeners().listeners,
          ..._KissListeners().listeners,
        ],
        child: const PagesStack(),
      ),
    );
  }
}

class _PairingListeners {
  List<PairingListener> get listeners => [
        requestReceived,
        pairingRequested,
      ];

  final requestReceived = PairingListener(
    listenWhen: (previous, current) {
      return previous.requestReceived != current.requestReceived;
    },
    listener: (context, state) async {
      final pairingProvider = context.read<PairingProvider>();
      await PairingRequest.showModal(context);
      pairingProvider.clearPairingState();
    },
  );

  final pairingRequested = PairingListener(
    listenWhen: (previous, current) {
      return !previous.pairingRequested && current.pairingRequested;
    },
    listener: (context, state) async {
      final pairingProvider = context.read<PairingProvider>();
      await Pairing.showModal(context);
      pairingProvider.clearPairingState();
    },
  );
}

class _MessagesListeners {
  List<MessagesListener> get listeners => [
        messageReceived,
        messageSent,
      ];

  final messageReceived = MessagesListener(
    listenWhen: (previous, current) {
      return previous.receivedMessage != current.receivedMessage;
    },
    listener: (context, state) {
      final message = state.receivedMessage!;
      final response = message.data!;
      if (message.isPairingRequest) {
        context.read<PairingProvider>().receivePairingRequest(
              pair: response.requestingUsername!,
              pairingCode: response.pairingCode!,
            );
      } else if (message.isPairingResponse) {
        context.read<UsersProvider>().savePair(
              pair: response.confirmedPair!,
            );
      }
    },
  );
  final messageSent = MessagesListener(
    listenWhen: (previous, current) {
      return previous.sentMessage != current.sentMessage;
    },
    listener: (context, state) async {
      MessagesProvider.sendToPair(context, message: state.sentMessage!);
    },
  );
}

class _KissListeners {
  List<KissListener> get listeners => [sentListener];
  final sentListener = KissListener(
    listenWhen: (previous, current) {
      return previous.sentKiss != current.sentKiss;
    },
    listener: (context, state) {
      // TODO sent
      context
          .read<StatusNotifierCubit>()
          .showSuccess(state.sentKiss!.type + ' sented!');
    },
  );
  final receivedListener = KissListener(
    listenWhen: (previous, current) {
      return previous.receivedKiss != current.receivedKiss;
    },
    listener: (context, state) {
      context
          .read<StatusNotifierCubit>()
          .showSuccess(state.receivedKiss!.type + ' received!');
    },
  );
}
