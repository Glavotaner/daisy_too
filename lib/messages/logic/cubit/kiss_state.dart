part of 'kiss_cubit.dart';

@freezed
class KissState extends Equatable with _$KissState {
  const KissState._();
  factory KissState({
    Kiss? sentKiss,
    Kiss? receivedKiss,
  }) = _KissState;
  static KissState get initial => KissState();

  @override
  List<Object?> get props => [sentKiss, receivedKiss];
}
