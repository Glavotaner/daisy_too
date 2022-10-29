part of 'users_cubit.dart';

@freezed
class UsersState extends Equatable with _$UsersState {
  const UsersState._();
  factory UsersState({
    required bool isRegistered,
    required bool isEditing,
    required bool isOnboarded,
    required String username,
    required String token,
    required String pair,
  }) = _UsersState;
  static UsersState get initial => UsersState(
        isRegistered: false,
        isEditing: false,
        isOnboarded: false,
        username: '',
        token: '',
        pair: '',
      );

  bool get hasPair => pair.isNotEmpty;
  bool get hasToken => token.isNotEmpty;
  bool get canMessage => hasPair && hasToken;

  @override
  List<Object?> get props => [isRegistered, isOnboarded, isEditing, username, token, pair];
}
