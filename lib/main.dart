import 'package:detect_tap_across_widgets_sample/model/tts_manager.dart';
import 'package:detect_tap_across_widgets_sample/view/home_screen.dart';
import 'package:flutter/material.dart';

TtsManager ttsManager = TtsManager();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
