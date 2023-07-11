import 'package:flutter_tts/flutter_tts.dart';

class TtsManager {
  final tts = FlutterTts();

  Future<void> speak(String speechText) async {
    await tts.speak(speechText);
  }

}