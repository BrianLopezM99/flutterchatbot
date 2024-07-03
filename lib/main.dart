import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchatbot/chat/bloc/chat_bloc.dart';
import 'package:flutterchatbot/chat/chat_home.dart';
import 'widgets/chat/chat_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ChatBloc>(
            create: (context) => ChatBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'Fake Chat',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Scaffold(
            body: Stack(
              children: [
                Center(
                  child: DashboardScreen(),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ChatWidget(),
                ),
              ],
            ),
          ),
        ));
  }
}
