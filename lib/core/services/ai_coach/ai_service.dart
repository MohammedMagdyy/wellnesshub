import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../helper_class/userInfo_local.dart';
import '../../utils/global_var.dart';
import '../getUserInfo_service.dart';


class GeminiService {
  static const String _apiKey = 'AIzaSyDaGyY5_PpGYrAsCdSD3fF0Ndw5Xb1vZVo';
  static const String _apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$_apiKey";

  static final List<Map<String, dynamic>> _conversation = [];

  static Map<String, dynamic> _client = {
    "name": "User",
    "height": 0,
    "weight": 0,
    "energy": "Medium",
    "activity": "Moderate",
    "exercises": "None",
  };

  static bool _hasStarted = false;

  /// 🔥 Load real user data from SharedPreferences
  static Future<void> initClientData() async {
    final userData = await GetUserInfoService().getUserInfo();
    
    _client = {
      "name": userData.firstName ?? "User",
      "height": userData.height ?? 0,
      "weight": userData.weight ?? 0,
      "activity": userData.activityLevel ?? "Moderate",
      "experience": userData.experienceLevel ?? "Beginner",
      "goal": userData.goal ?? "None",
    };
  }

  static String get _initialPrompt => """
Hi, I want you to act like a professional fitness coach for our client.

You are a professional fitness coach assigned to help our client.

Persona:
- Speak in a friendly, motivational, and supportive tone.
- Your coaching style is realistic, clear, and straight to the point.
- You must sound natural, never robotic or overly dramatic.
- When replying in Arabic, use the Egyptian colloquial dialect (اللهجة المصرية).
  - Use simple, friendly, and motivational expressions familiar to Egyptians.
  - Avoid Modern Standard Arabic (العربية الفصحى) and avoid Franco-Arabic (e.g., using English letters for Arabic words).
- When replying in English, use simple, clear, and motivational English.

Client Profile:
Name: ${_client['name']}
Height: ${_client['height']} cm
Weight: ${_client['weight']} kg
Activity level: ${_client['activity']}
experience:${_client['exercises']} ,
goal:${_client['goal']} ,
,

Behavior Rules:
- Only answer questions related to fitness, health, exercise, or diet.
- If asked something unrelated, politely decline and guide the client back to fitness topics.
- Always provide an answer based on the available information.
- If data is missing, assume reasonable defaults when possible and politely ask for more details after giving your best answer.
- Keep each reply short (under 100 words) unless a longer explanation is absolutely necessary.
- Maintain a respectful, positive, and motivational tone at all times.
- Speak to the client politely and respectfully. 
  - Do not use overly casual terms like "ya 3am" or "ya basha."
  - You may Address the client using their name or polite expressions like "يا كوتش" if speaking in Arabic.
- Respond in the same language the client uses:
  - If the client writes in Arabic, reply in Egyptian Arabic (اللهجة المصرية).
  - If the client writes in English, reply in friendly and clear English.
  - Never mix languages within the same reply.

First Interaction:
- Introduce yourself as their fitness coach in Arabic. 
- Congratulate the client if today's exercises are provided.
- Ask how they are feeling today and what they would like to focus on in today's session.
""";


  static Future<String> sendMessage(String userInput) async {
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
      print(response.body);
      return "❌ Error: ${response.body}";

    }
  }
}
