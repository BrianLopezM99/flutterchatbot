part of 'chat_bloc.dart';

@immutable
abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;
  final bool isTyping;
  final bool isMinimized;
  final String currentText;
  final bool isEmojiVisible;
  final bool? isShowingNotification;

  const ChatLoaded({
    required this.messages,
    required this.isTyping,
    required this.isMinimized,
    required this.currentText,
    required this.isEmojiVisible,
    this.isShowingNotification,
  });

  @override
  List<Object> get props =>
      [messages, isTyping, isMinimized, currentText, isEmojiVisible];
}
