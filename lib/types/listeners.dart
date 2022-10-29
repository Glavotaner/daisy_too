import 'package:daisy_too/types/providers.dart';
import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daisy_too/messages/logic/cubit/kiss_cubit.dart';
import 'package:daisy_too/messages/logic/cubit/messages_cubit.dart';

typedef MessagesListener = BlocListener<MessagesProvider, MessageState>;
typedef KissListener = BlocListener<KissProvider, KissState>;
typedef PairingListener = BlocListener<PairingProvider, PairingState>;
typedef UsersListener = BlocListener<UsersProvider, UsersState>;
