import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCoach;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCoach,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCoach ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: isCoach ? Colors.grey[300] : Colors.blueAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isCoach ? Colors.black87 : Colors.white,
          ),
        ),
      ),
    );
  }
}
