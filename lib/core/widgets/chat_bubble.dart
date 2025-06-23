import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: isCoach ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
            color: isCoach
                ? (isDark ? darkPeerBubbleColor : lightPeerBubbleColor)
                : (isDark ? darkUserBubbleColor : lightUserBubbleColor),
            borderRadius: isCoach
                ? BorderRadius.only(
                    bottomRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            border: isCoach
                ? Border.all(
                    color: isDark ? darkPeerTextColor : lightPeerTextColor)
                : Border.all(
                    color: isDark ? darkUserTextColor : lightUserTextColor)),
        child: Text(
          message,
          style: TextStyle(
            color: isCoach
                ? (isDark ? darkPeerTextColor : lightPeerTextColor)
                : (isDark ? darkUserTextColor : lightUserTextColor),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
