import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';


class AiService{
  static const String_baseUrl= 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  Future<String> getMedicationInfo(String medicationName) async{
    final url = Uri.parse('$_baseUrl?key=${ApiConfig.geminiApiKey}');
  }
}