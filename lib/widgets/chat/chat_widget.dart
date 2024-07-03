import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchatbot/chat/bloc/chat_bloc.dart';

import './chat_container_widget.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isShowingNotification = false;
  final notifyNum = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatInitial) {
          BlocProvider.of<ChatBloc>(context).add(FirstMessage());
          return buildChatContainer(context, [], false, true, '', false,
              _controller, _focusNode, notifyNum, false);
        } else if (state is ChatLoaded) {
          _isShowingNotification = state.isShowingNotification ?? true;
          _controller.text = state.currentText;
          _controller.selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length));
          return buildChatContainer(
              context,
              state.messages,
              state.isTyping,
              state.isMinimized,
              state.currentText,
              state.isEmojiVisible,
              _controller,
              _focusNode,
              notifyNum,
              _isShowingNotification);
        } else {
          return Container();
        }
      },
    );
  }
}
