import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQ')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Frequently Asked Questions will appear here.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
