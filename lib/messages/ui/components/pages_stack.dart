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
      final preferences = await KeyValueStorageSharedPrefs.instance;
      await preferences.implementation.reload();
      final actionMessages = await Future.wait([
        preferences.get<String>(key: MessageActionKeys.copyPairingCode),
        preferences.get<String>(key: MessageActionKeys.sendKissBacc),
      ]);
      final copy = actionMessages[0];
      if (copy != null) {
        context.read<PairingCubit>().copyPairingCode(copy);
        preferences.remove(key: MessageActionKeys.copyPairingCode);
        return;
      }
      final sendBacc = actionMessages[1];
      if (sendBacc != null) {
        final kiss = Kiss.fromMessage(jsonDecode(sendBacc));
        context.read<KissCubit>().sendKiss(kiss);
        preferences.remove(key: MessageActionKeys.sendKissBacc);
        return;
      }
      context.read<PairingCubit>().handleMessagesOnAppResume();
    }
  }
}
