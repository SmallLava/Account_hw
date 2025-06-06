import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _isAvailable = false;
  String _text = "";

  Future<void> initSpeech() async {
    _isAvailable = await _speech.initialize();
  }

  void listening(onResult) {
    if (_isAvailable) {
      _speech.listen(
        onResult: (result) {
          _text = result.recognizedWords;
          onResult(_text);
        },
      );
      bool isListening = true;

      Future.delayed(
          Duration(seconds: 8), () {
        if (isListening) {
          _speech.stop();
          isListening = false;
        }
      });
    }
  }
}