import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:convert';
import 'package:account_hw/constants.dart';

String format = '。把以上的敘述以以下格式回傳 {"title" : (標題), "price" : (價錢), "date" : (時間 格式為yyyy-mm-dd), "isIncome" : (根據敘述 是收入則true反之false), "type" : (根據敘述決定類別,是收入則包含$income,是支出則包含$expense)';
class GeminiService {
  void sendToGemini() {
    Gemini.init(apiKey: apiKey, enableDebugging: true);

    Gemini.instance.prompt(parts: [
      Part.text('我今天中午吃麥當勞花了兩百元$format'),
    ]).then((value) {
      String result = value!.output!.replaceAll('```json', '').replaceAll('```', '');
      if(result.isNotEmpty)
      {
        final jsonFormatResponse = jsonDecode(result);

      }
    });
  }
}

// Gemini.init(apiKey: apiKey, enableDebugging: true);
//
// Gemini.instance.prompt(parts: [
// Part.text('我今天中午吃麥當勞花了兩百元$format'),
// ]).then((value) {
// String result = value!.output!.replaceAll('```json', '').replaceAll('```', '');
// if(result.isNotEmpty)
// {
// final jsonFormatResponse = jsonDecode(result);
// print(jsonFormatResponse);
// }
// });