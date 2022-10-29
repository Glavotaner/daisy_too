import 'dart:developer';

import 'package:daisy_too/global/logic/cubit/status_notifier_cubit.dart';
import 'package:daisy_too/global/router/root_router.dart';
import 'package:daisy_too/messages/logic/cubit/messages_cubit.dart';
import 'package:daisy_too/types/listeners.dart';
import 'package:daisy_too/types/providers.dart';
import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:daisy_too/users/ui/components/pairing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:key_value/key_value.dart';
import 'package:messaging/messaging.dart';
import 'package:users/users.dart';
import 'package:web_api/implementation/web_api_http.dart';
import 'package:firebase_core/firebase_core.dart';
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
  GetIt.I.registerLazySingleton<Users>(() => users);
  final statusNotifier = StatusNotifierCubit();
  final usersProvider = UsersCubit(
    keyValueStorage: keyValueSharedPrefs,
    users: users,
    statusNotifier: statusNotifier,
  );
  final messagingApi = Messaging(api: apiProtocol);
  final messagesProvider = MessagesCubit(
    keyValueStorage: keyValueSharedPrefs,
    messaging: messagingApi,
    statusNotifier: statusNotifier,
  );
  final pairingProvider = PairingCubit(
    users: users,
    statusNotifier: statusNotifier,
  );
  runApp(DaisyTooApp(
    usersProvider: usersProvider,
    pairingProvider: pairingProvider,
    messagesProvider: messagesProvider,
    statusNotifier: statusNotifier,
  ));
  FlutterNativeSplash.remove();
}

class DaisyTooApp extends StatelessWidget {
  final UsersProvider usersProvider;
  final PairingProvider pairingProvider;
  final MessagesProvider messagesProvider;
  final StatusNotifierCubit statusNotifier;

  const DaisyTooApp({
    required this.usersProvider,
    required this.pairingProvider,
    required this.messagesProvider,
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
        BlocProvider.value(value: messagesProvider..init()),
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
              return current.responseSent && !previous.responseSent;
            },
            listener: (context, state) async {
              final user = context.read<UsersProvider>().state.username;
              final pairingState = context.read<PairingProvider>().state;
              final pair = pairingState.pair;
              final pairingResponse = pairingState.pairingCode;
              try {
                await users.respondPair(
                  requestingUsername: user,
                  respondingUsername: pair,
                  pairingResponse: pairingResponse,
                );
                context.read<StatusNotifierCubit>().showSuccess(
                      'Pairing confirmed!',
                    );
                context.read<UsersProvider>().savePair(pair: state.pair);
                if (!context.read<UsersProvider>().state.isOnboarded) {
                  context.read<UsersProvider>().onboardUser();
                }
              } catch (exception) {
                log(exception.toString());
                if (exception is BadRequest) {
                  context.read<StatusNotifierCubit>().showError(
                        exception.message,
                      );
                }
              }
            },
          ),
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
      actions: const [PairingButton()],
      title: const Text('Daisy'),
    );
  }
}

Users get users => GetIt.I<Users>();
