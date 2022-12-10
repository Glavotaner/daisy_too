part of '../messages.dart';

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
          children: const [KissRequest(), KissSelection()],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: SwipeHint.animated(pageController: _pageController),
        )
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final data = await messaging.getStoredMessage();
      if (data == null) return;
      context.read<PairingCubit>().handlePotentialPairingMessage(data);
    }
  }
}
