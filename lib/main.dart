import 'package:daisy_too/global/logic/cubit/status_notifier_cubit.dart';
import 'package:daisy_too/messages/logic/services/messaging.dart';
import 'package:daisy_too/messages/ui/messages.dart';
import 'package:daisy_too/splash/splash.dart';
import 'package:daisy_too/types/listeners.dart';
import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:daisy_too/users/ui/registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:messaging/messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users/users.dart';
import 'package:web_api/implementation/web_api_http.dart';

import 'firebase_options.dart';

main() {
  bootstrap();
}

Future<void> bootstrap() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final apiProtocol = WebApiHttp();
  final users = Users(api: apiProtocol);
  final messagingApi = Messaging(api: apiProtocol);
  final messaging = MessagingService(messaging: messagingApi);
  final statusNotifier = StatusNotifierCubit();
  final sharedPrefs = await SharedPreferences.getInstance();
  GetIt.I.registerLazySingleton<Users>(() => users);
  GetIt.I.registerLazySingleton<MessagingService>(() => messaging);
  GetIt.I.registerLazySingleton<StatusNotifierCubit>(() => statusNotifier);
  GetIt.I.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  final usersProvider = UsersCubit(users: users);
  final pairingProvider = PairingCubit();
  runApp(DaisyTooApp(
    usersProvider: usersProvider,
    pairingProvider: pairingProvider,
    statusNotifier: statusNotifier,
  ));
  FlutterNativeSplash.remove();
}

class DaisyTooApp extends StatelessWidget {
  final UsersCubit usersProvider;
  final PairingCubit pairingProvider;
  final StatusNotifierCubit statusNotifier;

  const DaisyTooApp({
    required this.usersProvider,
    required this.pairingProvider,
    required this.statusNotifier,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MultiBlocProvider(
      providers: [
        BlocProvider.value(value: statusNotifier),
        BlocProvider.value(value: usersProvider..checkUser()),
        BlocProvider.value(value: pairingProvider),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<StatusNotifierCubit, StatusNotifierState>(
              listener: (context, state) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(state.snackBar!);
          }),
          PairingListener(
            listenWhen: (previous, current) {
              final previousResponse = previous.receivedPairingResponse;
              final currentResponse = current.receivedPairingResponse;
              return currentResponse != null &&
                  currentResponse != previousResponse;
            },
            listener: (context, state) {
              final pair = state.receivedPairingResponse!.confirmedPair;
              context.read<UsersCubit>().savePair(pair: pair);
              context
                  .read<StatusNotifierCubit>()
                  .showSuccess('You are paired with $pair!');
            },
          )
        ],
        child: Scaffold(
          appBar: DaisyAppBar(),
          body: Router(
            routerDelegate: _RootRouter(),
            backButtonDispatcher: RootBackButtonDispatcher(),
          ),
        ),
      ),
    ));
  }
}

class _RootRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  _RootRouter() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final isOnboarded = context.select((UsersCubit cubit) {
      return cubit.state.isOnboarded;
    });
    return Navigator(
      pages: [
        if (isOnboarded ?? false) MessagesPage.page(),
        if (isOnboarded != null && !isOnboarded) Registration.page(),
        if (isOnboarded == null) SplashScreen.page(),
      ],
      onPopPage: (route, result) => false,
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    return Future.value();
  }
}

class DaisyAppBar extends AppBar {
  DaisyAppBar({Key? key}) : super(key: key);

  @override
  State<AppBar> createState() => _DaisyAppBarState();
}

class _DaisyAppBarState extends State<DaisyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        systemNavigationBarColor: Colors.white,
      ),
      actions: const [_AppBarPairingButton()],
      title: const Text('Daisy'),
    );
  }
}

class _AppBarPairingButton extends StatelessWidget {
  const _AppBarPairingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UsersCubit.isOnboarded(context)
        ? const _PairButton()
        : const IgnorePointer(ignoring: true);
  }
}

class _PairButton extends StatelessWidget {
  const _PairButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasPair = context.select((UsersCubit value) => value.state.hasPair);
    return TextButton.icon(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(
          hasPair ? Colors.redAccent : Colors.white,
        ),
      ),
      onPressed: context.read<PairingCubit>().requestPair,
      icon: const Icon(Icons.favorite),
      label: const Text('Pair'),
    );
  }
}

Users get users => GetIt.I<Users>();
MessagingService get messaging => GetIt.I<MessagingService>();
StatusNotifierCubit get statusNotifier => GetIt.I<StatusNotifierCubit>();
SharedPreferences get sharedPreferences => GetIt.I<SharedPreferences>();
