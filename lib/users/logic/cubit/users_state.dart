part of 'users_cubit.dart';

@freezed
class UsersState extends Equatable with _$UsersState {
  const UsersState._();
  factory UsersState({
    required bool isRegistered,
    required bool isRegistering,
    required bool? isOnboarded,
    required String username,
    required String token,
    required String pair,
  }) = _UsersState;
  factory UsersState.initial() => UsersState(
        isRegistered: false,
        isRegistering: false,
        isOnboarded: null,
        username: '',
        token: '',
        pair: '',
      );

  bool get hasPair => pair.isNotEmpty;
  bool get hasToken => token.isNotEmpty;
  bool get canMessage => hasPair && hasToken;

  @override
  List<Object?> get props => [
        isRegistered,
        isRegistering,
        isOnboarded,
        username,
        token,
        pair,
      ];
}
