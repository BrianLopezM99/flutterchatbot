import 'package:flutter/material.dart';

class CircleNotification extends StatelessWidget {
  final int notifyNum;
  final bool isEnabled;

  const CircleNotification(
      {super.key, required this.notifyNum, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return isEnabled
        ? CircleAvatar(
            backgroundColor: Colors.red,
            radius: 10,
            child: Text(
              '$notifyNum',
              style: const TextStyle(color: Colors.white),
            ),
          )
        : const SizedBox();
  }
}
