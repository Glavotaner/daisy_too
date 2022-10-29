part of 'messages_cubit.dart';

@freezed
class MessageState extends Equatable with _$MessageState {
  const MessageState._();
  factory MessageState({
    required bool sending,
    Message? receivedMessage,
    Message? sentMessage,
  }) = _MessageState;

  static MessageState get initial => MessageState(sending: false);

  @override
  List<Object?> get props => [sending, receivedMessage, sentMessage];
}
