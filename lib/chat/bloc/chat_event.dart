part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends ChatEvent {
  final String message;

  const SendMessage(this.message);

  @override
  List<Object> get props => [message];
}

class ReceiveMessage extends ChatEvent {
  final String message;

  const ReceiveMessage(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateCurrentText extends ChatEvent {
  final String text;

  const UpdateCurrentText(this.text);

  @override
  List<Object> get props => [text];
}

class ToggleEmojiKeyboard extends ChatEvent {}

class AddEmoji extends ChatEvent {
  final String emoji;

  const AddEmoji(this.emoji);

  @override
  List<Object> get props => [emoji];
}

class BackspaceEmoji extends ChatEvent {}

class MinimizeChat extends ChatEvent {
  final bool isnShowingNotification;

  const MinimizeChat(this.isnShowingNotification);
}

class MaximizeChat extends ChatEvent {}

class FirstMessage extends ChatEvent {}
