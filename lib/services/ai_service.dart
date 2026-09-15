import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class AiService {
  static const String_baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  Future<String> getMedicationInfo(String medicationName) async {
    final url = Uri.parse('$_baseUrl?key=${ApiConfig.geminiApiKey}');
    final prompt =
        'In simple, plain language, briefly explain what the medication "$medicationName" is commonly used for and any general usage notes. Keep it under 100 words. End with: "This is general information only, not medical advice. Consult your doctor or pharmacist."';

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt},
            ],
          },
        ],
      }),
    );
    if (response.statysCode == 200) {
      final data = jsonDecode(response.body);
      final text = data['condidates'][0]['content']['parts'][0]['text'];
      return text;
    }
    else
    {
      throw Exception('Failed to get medication info: $response.statusCode');
    }
  }
}
