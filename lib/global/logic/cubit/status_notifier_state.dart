part of 'status_notifier_cubit.dart';

@freezed
class StatusNotifierState with _$StatusNotifierState {
  const factory StatusNotifierState({
    SnackBar? snackBar,
  }) = _StatusNotifierState;
}
