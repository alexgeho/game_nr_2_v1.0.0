import 'package:flutter/material.dart';
import 'screens/age_selector_screen.dart'; // 👈 добавь импорт

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AgeSelectorScreen(), // 👈 Вот это запускается первым
    );
  }
}
