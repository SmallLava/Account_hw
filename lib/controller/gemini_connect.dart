import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:convert';
import 'package:account_hw/constants.dart';
import 'package:account_hw/secret_config.dart';

String format = '。把以上的敘述以以下格式回傳 {"title" : (標題), "price" : (價錢), "date" : (時間 格式為yyyy, mm, dd), "isIncome" : (根據敘述 是收入則true反之false), "type" : (根據敘述決定類別,是收入則包含$income,是支出則包含$expense)';
class GeminiService {
  Future<Map<String, dynamic>> sendToGemini(String input) async{
    Gemini.init(apiKey: apiToken, enableDebugging: true);

    final value = await Gemini.instance.prompt(
      parts: [Part.text(input + format)],
    );

    if (value != null && value.output != null) {
      final result = value.output!
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      if (result.isNotEmpty) {
        return jsonDecode(result);
      }
    }

    return {};
  }
}