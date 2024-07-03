import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchatbot/chat/bloc/chat_bloc.dart';
import 'package:flutterchatbot/chat/chat_message.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutterchatbot/widgets/chat/notification_widget.dart';

Widget buildChatContainer(
    BuildContext context,
    List<ChatMessage> messages,
    bool isTyping,
    bool isMinimized,
    String currentText,
    bool isEmojiVisible,
    TextEditingController controller,
    FocusNode focusNode,
    int notifyNum,
    bool isShowingNotification) {
  return Stack(
    children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isMinimized ? 60 : 300,
        height: isMinimized ? 60 : 500,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: isMinimized
            ? GestureDetector(
                onTap: () {
                  BlocProvider.of<ChatBloc>(context).add(MaximizeChat());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(Icons.chat, color: Colors.white),
                ),
              )
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Chat',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.minimize, color: Colors.white),
                          onPressed: () {
                            BlocProvider.of<ChatBloc>(context)
                                .add(const MinimizeChat(false));
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return messages[messages.length - 1 - index];
                      },
                    ),
                  ),
                  if (isTyping)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 10),
                          Text("Typing..."),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintText: 'Type a message',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onChanged: (text) {
                                  BlocProvider.of<ChatBloc>(context)
                                      .add(UpdateCurrentText(text));
                                },
                                onSubmitted: (text) {
                                  BlocProvider.of<ChatBloc>(context)
                                      .add(SendMessage(text));
                                  controller.clear();
                                  BlocProvider.of<ChatBloc>(context)
                                      .add(const UpdateCurrentText(''));
                                  focusNode.requestFocus();
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.emoji_emotions),
                              onPressed: () {
                                BlocProvider.of<ChatBloc>(context)
                                    .add(ToggleEmojiKeyboard());
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                BlocProvider.of<ChatBloc>(context)
                                    .add(SendMessage(controller.text));
                                controller.clear();
                                BlocProvider.of<ChatBloc>(context)
                                    .add(const UpdateCurrentText(''));
                                focusNode.requestFocus();
                              },
                            ),
                          ],
                        ),
                        if (isEmojiVisible)
                          SizedBox(
                            height: 250,
                            child: EmojiPicker(
                              onEmojiSelected: (category, emoji) {
                                BlocProvider.of<ChatBloc>(context)
                                    .add(AddEmoji(emoji.emoji));
                                focusNode.requestFocus();
                              },
                              onBackspacePressed: () {
                                BlocProvider.of<ChatBloc>(context)
                                    .add(BackspaceEmoji());
                                focusNode.requestFocus();
                              },
                              config: const Config(
                                emojiTextStyle: TextStyle(fontSize: 24),
                                emojiViewConfig: EmojiViewConfig(),
                                skinToneConfig: SkinToneConfig(),
                                categoryViewConfig: CategoryViewConfig(),
                                bottomActionBarConfig: BottomActionBarConfig(),
                                searchViewConfig: SearchViewConfig(),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      isMinimized && messages.isNotEmpty && isShowingNotification == true
          ? CircleNotification(notifyNum: notifyNum, isEnabled: true)
          : const SizedBox(),
    ],
  );
}
