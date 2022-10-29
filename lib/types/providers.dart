import 'package:daisy_too/global/logic/cubit/status_notifier_cubit.dart';
import 'package:daisy_too/messages/logic/cubit/kiss_cubit.dart';
import 'package:daisy_too/messages/logic/cubit/messages_cubit.dart';
import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';

typedef UsersProvider = UsersCubit;
typedef PairingProvider = PairingCubit;
typedef MessagesProvider = MessagesCubit;
typedef KissProvider = KissCubit;
typedef StatusNotifier = StatusNotifierCubit;
