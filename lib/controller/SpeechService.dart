import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speech = SpeechToText();
  bool _isAvailable = false;
  String _text = "";
  Timer? _timer;

  Future<void> initSpeech() async {
    _isAvailable = await _speech.initialize();
  }

  void listening(Function(String) onResult) {
    if (_isAvailable) {
      _speech.listen(
        onResult: (result) {
          _text = result.recognizedWords;
          if (_text.trim().isNotEmpty) {
            onResult(_text);
          }
        },
        listenOptions: SpeechListenOptions(
          partialResults: true,
          cancelOnError: true,
          autoPunctuation: true,
        ),
      );

      _timer?.cancel();
      _timer = Timer(Duration(seconds: 8), () {
        if (_speech.isListening) {
          _speech.stop();
        }
      });
    }
  }

  void stop() {
    _timer?.cancel();
    _speech.stop();
  }

  bool isListening() => _speech.isListening;
}
