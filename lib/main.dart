import 'package:daisy_too/global/logic/cubit/status_notifier_cubit.dart';
import 'package:daisy_too/global/router/root_router.dart';
import 'package:daisy_too/messages/logic/services/messaging.dart';
import 'package:daisy_too/types/listeners.dart';
import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:daisy_too/users/ui/components/app_bar_pairing_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:key_value/key_value.dart';
import 'package:messaging/messaging.dart';
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
  final keyValueSharedPrefs = await KeyValueStorageSharedPrefs.instance;
  final apiProtocol = WebApiHttp();
  final users = Users(api: apiProtocol);
  final messagingApi = Messaging(api: apiProtocol);
  final messaging = MessagingService(
    messaging: messagingApi,
    keyValueStorage: keyValueSharedPrefs,
  );
  GetIt.I.registerLazySingleton<Users>(() => users);
  GetIt.I.registerLazySingleton<MessagingService>(() => messaging);
  final statusNotifier = StatusNotifierCubit();
  final usersProvider = UsersCubit(
    keyValueStorage: keyValueSharedPrefs,
    users: users,
    statusNotifier: statusNotifier,
  );
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
              final pair = state.receivedPairingResponse!.data!.confirmedPair!;
              context.read<UsersCubit>().savePair(pair: pair);
            },
          )
        ],
        child: Scaffold(
          appBar: DaisyAppBar(),
          body: Router(
            routerDelegate: RootRouter(),
            backButtonDispatcher: RootBackButtonDispatcher(),
          ),
        ),
      ),
    ));
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
      actions: const [AppBarPairingButton()],
      title: const Text('Daisy'),
    );
  }
}

Users get users => GetIt.I<Users>();
MessagingService get messaging => GetIt.I<MessagingService>();
