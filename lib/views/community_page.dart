import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/chat_bubble.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/message_input.dart';
import 'package:wellnesshub/core/services/ai_coach/ai_service.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});
  static const routeName = 'CommunityPage';

  @override
  State<CommunityPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<CommunityPage> {
  final List<Map<String, dynamic>> _messages = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeClient();
  }

  Future<void> _initializeClient() async {
    await GeminiService.initClientData(); // Load user info from SharedPreferences
    final firstReply = await GeminiService.sendMessage("");
    if (!mounted) return;
    setState(() {
      _messages.add({'text': firstReply, 'isCoach': true});
      _isLoading = false;
    });
  }

  void _handleSend(String message) async {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add({'text': message, 'isCoach': false});
    });

    try {
      final reply = await GeminiService.sendMessage(message);
      if (!mounted) return;
      setState(() {
        _messages.add({'text': reply, 'isCoach': true});
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _messages.add({
          'text': 'Something went wrong. Try again later.',
          'isCoach': true,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "AI Coach Chat"),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
