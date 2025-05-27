import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game History')),
      body: const Center(
        child: Text(
          'Your game history will appear here.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
