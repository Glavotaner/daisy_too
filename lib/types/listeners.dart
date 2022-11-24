import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daisy_too/messages/logic/cubit/kiss_cubit.dart';
import 'package:daisy_too/messages/logic/cubit/messages_cubit.dart';

typedef MessagesListener = BlocListener<MessagesCubit, MessageState>;
typedef KissListener = BlocListener<KissCubit, KissState>;
typedef PairingListener = BlocListener<PairingCubit, PairingState>;
typedef UsersListener = BlocListener<UsersCubit, UsersState>;
