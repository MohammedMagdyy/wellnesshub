import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/chat_bubble.dart';
import 'package:wellnesshub/core/widgets/message_input.dart';
import 'package:wellnesshub/core/widgets/ai_service.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});
  static const routeName = 'Chat';

  @override
  State<CommunityPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<CommunityPage> {
  final List<Map<String, dynamic>> _messages = [
    {'text': "Hi, how can I help you today?", 'isCoach': true},
  ];

  void _handleSend(String message) async {
    if (message.trim().isEmpty) return;
    setState(() {
      _messages.add({'text': message, 'isCoach': false});
    });

    try {
      final aiReply = await AIService.getAIReply(message);
      setState(() {
        _messages.add({'text': aiReply, 'isCoach': true});
      });
    } catch (e) {
      setState(() {
        _messages.add({'text': 'Sorry, something went wrong.', 'isCoach': true});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coach Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return ChatBubble(
                  message: msg['text'],
                  isCoach: msg['isCoach'],
                );
              },
            ),
          ),
          MessageInput(onSend: _handleSend),
        ],
      ),
    );
  }
}
