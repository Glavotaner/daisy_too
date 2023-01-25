import 'dart:async';

import 'package:daisy_too/global/logic/cubit/status_notifier_cubit.dart';
import 'package:daisy_too/main.dart';
import 'package:daisy_too/messages/logic/cubit/kiss_cubit.dart';
import 'package:daisy_too/messages/models/kiss/kiss.dart';
import 'package:daisy_too/types/listeners.dart';
import 'package:daisy_too/users/logic/cubit/pair_edit_cubit.dart';
import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';

import 'package:daisy_too/users/ui/components/request_pair_button.dart';
import 'package:daisy_too/users/ui/components/pairing_steps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    listener: (context, _) async {
      final provider = context.read<PairingCubit>();
      await _ReceivedPairingRequest.asModal(context);
      Timer(const Duration(milliseconds: 500), provider.clearMessages);
    },
  );

  final pairingRequested = PairingListener(
    listenWhen: (previous, current) {
      return !previous.pairingRequested && current.pairingRequested;
    },
    listener: (context, _) async {
      final provider = context.read<PairingCubit>();
      await _Pairing.asModal(context);
      provider.clearRequestedPairing();
    },
  );
}

class _KissListeners {
  List<KissListener> get listeners => [sentListener, receivedListener];

  final sentListener = KissListener(
    listenWhen: (_, current) {
      return current.sentKiss != null;
    },
    listener: (context, state) {
      final message = state.sentKiss!.type + ' sented!';
      context.read<StatusNotifierCubit>().showSuccess(message);
      context.read<KissCubit>().clearSentKiss();
    },
  );

  final receivedListener = KissListener(
    listenWhen: (previous, current) {
      return previous.receivedKiss == null && current.receivedKiss != null;
    },
    listener: (context, _) async {
      final provider = context.read<KissCubit>();
      await _ReceivedKiss.show(context);
      Timer(const Duration(milliseconds: 500), provider.clearReceivedKiss);
    },
  );
}

class _Pairing extends StatelessWidget {
  const _Pairing({Key? key}) : super(key: key);

  static asModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<PairingCubit>(),
          child: BlocProvider(
            create: (context) => PairEditCubit(
              pair: context.read<UsersCubit>().state.pair,
            ),
            child: PairEditListener(
              listenWhen: (_, current) {
                return current.sentPairingResponse;
              },
              listener: (context, state) {
                context.read<UsersCubit>().savePair(pair: state.pair);
                context
                    .read<StatusNotifierCubit>()
                    .showSuccess('You are paired with ${state.pair}!');
                Navigator.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: _Pairing(),
              ),
            ),
          ),
        );
      },
    );
  }

  static const _pairingRequestStep = 0;
  static const _pairingRequestedStep = 1;

  @override
  Widget build(BuildContext context) {
    final currentStep = _pairingStep(context);
    return Stepper(
      currentStep: currentStep,
      controlsBuilder: _buildControls,
      onStepTapped: (step) {
        if (step == _pairingRequestStep &&
            context.read<PairEditCubit>().state.sentPairingRequest) {
          context.read<PairEditCubit>().clearSentRequest();
        }
      },
      steps: [
        PairWithStep(context,
            state: currentStep == _pairingRequestStep
                ? StepState.editing
                : StepState.complete),
        PairRequestStep(context,
            state: currentStep == _pairingRequestedStep
                ? StepState.editing
                : null),
      ],
    );
  }

  Widget _buildControls(context, detail) {
    return detail.currentStep == _pairingRequestedStep
        ? const IgnorePointer()
        : const RequestPairButton();
  }

  int _pairingStep(BuildContext context) {
    final sentPairingRequest = PairEditCubit.sentPairingRequest(context);
    return sentPairingRequest ? _pairingRequestedStep : _pairingRequestStep;
  }
}

class _ReceivedPairingRequest extends StatelessWidget {
  const _ReceivedPairingRequest({Key? key}) : super(key: key);
  static asModal(BuildContext context) {
    return showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 200),
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<PairingCubit>(),
        child: PairingListener(
          listenWhen: (_, current) => current.receivedPairingResponse != null,
          listener: (context, _) {
            Navigator.of(context).pop();
          },
          child: const _ReceivedPairingRequest(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pairingRequest =
        context.read<PairingCubit>().state.receivedPairingRequest!;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: RichText(
                  text: TextSpan(
                text: 'Pair with ',
                children: [
                  TextSpan(
                    text: pairingRequest.requestingUsername,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18),
              )),
            ),
            TextButton.icon(
              onPressed: () => context.read<PairingCubit>().copyPairingCode(),
              label: const _PairingCode(),
              icon: const Icon(Icons.note_alt),
            ),
          ],
        ),
      ),
    );
  }
}

class _PairingCode extends StatelessWidget {
  const _PairingCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.select((PairingCubit value) {
        return value.state.receivedPairingRequest!.pairingCode;
      }),
      style: const TextStyle(fontSize: 24),
    );
  }
}

class _ReceivedKiss extends StatelessWidget {
  const _ReceivedKiss({Key? key}) : super(key: key);
  static show(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: context.read<KissCubit>(),
            child: const _ReceivedKiss(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 120),
      title: _KissHeader(),
      content: Center(
        child: _KissImage(),
      ),
      actions: [Center(child: _SendKissBackButton())],
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
      label: const Text(
        'Send kiss bacc',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  _sendBacc(BuildContext context) {
    final kiss = context.read<KissCubit>().state.receivedKiss!;
    context.read<KissCubit>().sendKiss(kiss);
    Navigator.of(context).pop();
  }
}

class PagesStack extends StatefulWidget {
  const PagesStack({Key? key}) : super(key: key);

  @override
  State<PagesStack> createState() => _PagesStackState();
}

class _PagesStackState extends State<PagesStack> with WidgetsBindingObserver {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          children: const [_KissRequest(), _KissSelection()],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: _SwipeHint.animated(pageController: _pageController),
        )
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      messaging.handleBackgroundNotificationActions();
      context.read<PairingCubit>().handleMessagesOnAppResume();
    }
  }
}

class _SwipeHint extends StatelessWidget {
  const _SwipeHint({required this.hint, required this.arrows, Key? key})
      : super(key: key);

  static animated({required PageController pageController}) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, _) {
        final page = pageController.page ?? 0;
        String hint = 'Swipe oop to send kiss';
        Icon arrows = const Icon(Icons.arrow_upward);
        AlignmentGeometry alignment = Alignment.bottomCenter;
        if (page > 0.6) {
          hint = 'Swipe down to ask for kiss';
          arrows = const Icon(Icons.arrow_downward);
          alignment = Alignment.topCenter;
        }
        final distanceFromMiddle = (page - 0.5).abs();
        return AnimatedAlign(
          alignment: alignment,
          duration: Duration.zero,
          child: Opacity(
            opacity: distanceFromMiddle * 1.5,
            child: _SwipeHint(
              hint: hint,
              arrows: arrows,
            ),
          ),
        );
      },
    );
  }

  final String hint;
  final Icon arrows;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        arrows,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            hint,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        arrows,
      ],
    );
  }
}

class _KissRequest extends StatefulWidget {
  const _KissRequest({Key? key}) : super(key: key);

  @override
  State<_KissRequest> createState() => _KissRequestState();
}

class _KissRequestState extends State<_KissRequest> {
  final _controller = TextEditingController();

  _sendRequest(BuildContext context) {
    final request = Kiss.fromRequest(_controller.value.text);
    context.read<KissCubit>().sendKiss(request);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            Expanded(
                child: Stack(
                  children: [
                    Center(
                      child: Material(
                        child: Image.asset('assets/kisses/request.png'),
                      ),
                    ),
                    _KissTap(onTap: () => _sendRequest(context)),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: _controller,
                textAlign: TextAlign.center,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Request kiss here',
                ),
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KissTap extends StatelessWidget {
  const _KissTap({required this.onTap, Key? key}) : super(key: key);

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

class _KissSelection extends StatefulWidget {
  const _KissSelection({Key? key}) : super(key: key);

  @override
  State<_KissSelection> createState() => _KissSelectionState();
}

class _KissSelectionState extends State<_KissSelection>
    with TickerProviderStateMixin {
  final kisses = [
    Kiss(
      type: 'baby kiss',
      imageFile: 'boss-baby.png',
      message: 'You received just a small babby kiss!',
    ),
    Kiss(
      type: 'boss baby kiss',
      imageFile: 'boss-baby.png',
      message: 'Wao you received boss baby kiss!',
    ),
    Kiss(
      type: 'big kiss',
      imageFile: 'boss-baby.png',
      message: 'You just received biiiig kiss!',
    ),
  ];
  late PageController _pageController;

  _animateToInitialPage() {
    final middleKissIndex = (kisses.length / 2).floor();
    Timer(const Duration(milliseconds: 100), () {
      _pageController.animateToPage(
        middleKissIndex,
        duration: const Duration(milliseconds: 1500),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.7,
    );
    _animateToInitialPage();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      itemCount: kisses.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 70),
            child: AnimatedBuilder(
              animation: _pageController,
              builder: (ctx, _) {
                if (!_pageController.hasClients ||
                    !_pageController.position.hasContentDimensions) {
                  return const SizedBox();
                }
                final page = _pageController.page!;
                final selectedIndex = page.roundToDouble();

                final pageScrollAmount = page - selectedIndex;

                final maxScrollDistance = kisses.length / 2;

                final pageDistanceFromSelected =
                (selectedIndex - index + pageScrollAmount).abs();

                final percentFromCenter =
                    1.0 - pageDistanceFromSelected / maxScrollDistance;

                final itemScale = 0.5 + (percentFromCenter * 0.5);
                final opacity = 0.25 + (percentFromCenter * 0.75);

                return Transform.scale(
                  scale: itemScale,
                  child: Opacity(
                    opacity: opacity,
                    child: _Kiss(kiss: kisses[index]),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _Kiss extends StatelessWidget {
  const _Kiss({required this.kiss, Key? key}) : super(key: key);

  final Kiss kiss;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(kiss.assetPath!),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Chip(
                    label: Text(
                      kiss.type,
                      style: const TextStyle(fontSize: 24),
                    ),
                    backgroundColor: Colors.redAccent.withAlpha(100),
                  ),
                ),
              ],
            ),
          ),
          _KissTap(
            onTap: () {
              context.read<KissCubit>().sendKiss(kiss);
            },
          )
        ],
      ),
    );
  }
}
