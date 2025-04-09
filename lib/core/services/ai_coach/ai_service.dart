import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey = 'AIzaSyAt_qPOoVYM9jZgIYaRSqZ6Ds1Pmwysk-c';
  static const String _apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key=$_apiKey";

  static final List<Map<String, dynamic>> _conversation = [];

  static final _client = {
    "name": "Omar",
    "height": 178,
    "weight": 82,
    "energy": "Medium",
    "activity": "Moderate",
    "exercises": "30 min cardio, 20 min weight training",
  };

  static String get _initialPrompt => """
Hi Gemini, I want you to act like a professional fitness coach for our client.

Client info:
- Name: ${_client['name']}
- Height: ${_client['height']} cm
- Weight: ${_client['weight']} kg
- Energy level: ${_client['energy']}
- Activity level: ${_client['activity']}
- Exercises done today: ${_client['exercises']}

Your role:
- Only answer questions related to fitness, health, exercise, or diet.
- Be professional, motivational, and always polite.
- If the user asks something unrelated, kindly remind them you're their fitness coach.
- Explain all concepts in a simple, friendly, coaching tone.

Please introduce yourself and ask ${_client['name']} how he feels today and what he'd like to focus on in today's session.
""";

  static bool _hasStarted = false;

  static Future<String> sendMessage(String userInput) async {
    // Send initial prompt once
    if (!_hasStarted) {
      _conversation.add({
        "role": "user",
        "parts": [
          {"text": _initialPrompt}
        ]
      });
      _hasStarted = true;
    }

    if (userInput.trim().isNotEmpty) {
      _conversation.add({
        "role": "user",
        "parts": [
          {"text": userInput}
        ]
      });
    }

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"contents": _conversation}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final reply = data['candidates'][0]['content']['parts'][0]['text'];

      _conversation.add({
        "role": "model",
        "parts": [
          {"text": reply}
        ]
      });

      return reply;
    } else {
      return "❌ Error: ${response.body}";
    }
  }
}
