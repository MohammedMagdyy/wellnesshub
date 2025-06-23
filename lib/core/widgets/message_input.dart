import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';

class MessageInput extends StatefulWidget {
  final void Function(String) onSend;

  const MessageInput({super.key, required this.onSend});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();

  void _send() {
    widget.onSend(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        style:TextStyle(color: isDark? darkChatInputTextColor : lightChatInputTextColor) ,
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Type a message...',
          hintStyle: TextStyle(color: isDark? darkChatInputTextColor : lightChatInputTextColor),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.send,
              color: isDark? darkChatSendIconColor : lightChatSendIconColor,
            ),
            onPressed: _send,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isDark? darkChatInputBarFocusedBorderColor : lightChatInputBarFocusedBorderColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isDark? darkChatInputBarEnabledBorderColor : lightChatInputBarEnabledBorderColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
      ),
    );
  }
}
