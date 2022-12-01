import 'package:daisy_too/users/logic/cubit/pair_edit_cubit.dart';
import 'package:daisy_too/users/logic/cubit/pairing_cubit.dart';
import 'package:daisy_too/users/logic/cubit/users_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daisy_too/messages/logic/cubit/kiss_cubit.dart';

typedef KissListener = BlocListener<KissCubit, KissState>;
typedef PairingListener = BlocListener<PairingCubit, PairingState>;
typedef PairEditListener = BlocListener<PairEditCubit, PairEditState>;
typedef UsersListener = BlocListener<UsersCubit, UsersState>;
