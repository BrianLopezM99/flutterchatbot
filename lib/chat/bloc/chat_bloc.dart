import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../chat_message.dart';
import '../mocks/bot_messages.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final List<ChatMessage> _messages = [];
  final List<String> _botResponses = botMessages;
  String _currentText = '';
  bool _isTyping = false;
  bool _isMinimized = false;
  bool _isEmojiVisible = false;

  ChatBloc() : super(ChatInitial()) {
    on<SendMessage>(_onSendMessage);
    on<ReceiveMessage>(_onReceiveMessage);
    on<UpdateCurrentText>(_onUpdateCurrentText);
    on<ToggleEmojiKeyboard>(_onToggleEmojiKeyboard);
    on<AddEmoji>(_onAddEmoji);
    on<BackspaceEmoji>(_onBackspaceEmoji);
    on<MinimizeChat>(_onMinimizeChat);
    on<MaximizeChat>(_onMaximizeChat);
    on<FirstMessage>(_onFirstMessage);
  }

  void _onSendMessage(SendMessage event, Emitter<ChatState> emit) {
    int randomSeconds = Random().nextInt(5) + 1;
    int randomMilliseconds = randomSeconds * 1000;
    _messages.add(ChatMessage(
        text: event.message, isUser: true, timestamp: DateTime.now()));
    _isTyping = true;
    emit(ChatLoaded(
      messages: List.from(_messages),
      isTyping: _isTyping,
      isMinimized: _isMinimized,
      currentText: _currentText,
      isEmojiVisible: _isEmojiVisible,
    ));
    Future.delayed(Duration(milliseconds: randomMilliseconds), () {
      final response = _botResponses[Random().nextInt(_botResponses.length)];
      add(ReceiveMessage(response));
    });
  }

  void _onReceiveMessage(ReceiveMessage event, Emitter<ChatState> emit) {
    _messages.add(ChatMessage(
        text: event.message, isUser: false, timestamp: DateTime.now()));
    _isTyping = false;
    emit(ChatLoaded(
      messages: List.from(_messages),
      isTyping: _isTyping,
      isMinimized: _isMinimized,
      currentText: _currentText,
      isEmojiVisible: _isEmojiVisible,
    ));
  }

  void _onUpdateCurrentText(UpdateCurrentText event, Emitter<ChatState> emit) {
    _currentText = event.text;
    emit(ChatLoaded(
      messages: List.from(_messages),
      isTyping: _isTyping,
      isMinimized: _isMinimized,
      currentText: _currentText,
      isEmojiVisible: _isEmojiVisible,
    ));
  }

  void _onToggleEmojiKeyboard(
      ToggleEmojiKeyboard event, Emitter<ChatState> emit) {
    _isEmojiVisible = !_isEmojiVisible;
    emit(ChatLoaded(
      messages: List.from(_messages),
      isTyping: _isTyping,
      isMinimized: _isMinimized,
      currentText: _currentText,
      isEmojiVisible: _isEmojiVisible,
    ));
  }

  void _onAddEmoji(AddEmoji event, Emitter<ChatState> emit) {
    _currentText += event.emoji;
    emit(ChatLoaded(
      messages: List.from(_messages),
      isTyping: _isTyping,
      isMinimized: _isMinimized,
      currentText: _currentText,
      isEmojiVisible: _isEmojiVisible,
    ));
  }

  void _onBackspaceEmoji(BackspaceEmoji event, Emitter<ChatState> emit) {
    if (_currentText.isNotEmpty) {
      _currentText = _currentText.substring(0, _currentText.length - 1);
      emit(ChatLoaded(
        messages: List.from(_messages),
        isTyping: _isTyping,
        isMinimized: _isMinimized,
        currentText: _currentText,
        isEmojiVisible: _isEmojiVisible,
      ));
    }
  }

  void _onMinimizeChat(MinimizeChat event, Emitter<ChatState> emit) {
    _isMinimized = true;
    bool isShowingNotification = event.isnShowingNotification;
    emit(ChatLoaded(
      messages: List.from(_messages),
      isTyping: _isTyping,
      isMinimized: _isMinimized,
      currentText: _currentText,
      isEmojiVisible: _isEmojiVisible,
      isShowingNotification: isShowingNotification,
    ));
  }

  void _onMaximizeChat(MaximizeChat event, Emitter<ChatState> emit) {
    _isMinimized = false;
    emit(ChatLoaded(
      messages: List.from(_messages),
      isTyping: _isTyping,
      isMinimized: _isMinimized,
      currentText: _currentText,
      isEmojiVisible: _isEmojiVisible,
    ));
  }

  void _onFirstMessage(FirstMessage event, Emitter<ChatState> emit) async {
    _isMinimized = true;
    await Future.delayed(const Duration(seconds: 5), () {
      final response = _botResponses[0];
      emit(ChatLoaded(
        messages: List.from(_messages),
        isTyping: _isTyping,
        isMinimized: _isMinimized,
        currentText: _currentText,
        isEmojiVisible: _isEmojiVisible,
      ));
      add(ReceiveMessage(response));
    });
  }
}
