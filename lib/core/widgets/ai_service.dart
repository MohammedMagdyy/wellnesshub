import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const _apiKey = 'YOUR_OPENAI_API_KEY'; // Replace this with your key
  static const _apiUrl = 'https://api.openai.com/v1/chat/completions';

  static Future<String> getAIReply(String message) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": "You are a helpful fitness coach."},
          {"role": "user", "content": message},
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'].trim();
    } else {
      throw Exception("Failed to get AI response");
    }
  }
}
