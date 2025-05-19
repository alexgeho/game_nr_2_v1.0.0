import 'package:flutter/material.dart';
import 'home_screen.dart';

class AgeSelectorScreen extends StatelessWidget {
  const AgeSelectorScreen({super.key});

  final List<Map<String, String>> segments = const [
    {"label": "Ages 6–8 (Grades 1–2)", "segment": "Junior1"},
    {"label": "Ages 8–10 (Grades 3–4)", "segment": "Junior2"},
    {"label": "Ages 10–12 (Grades 5–6)", "segment": "Middle"},
    {"label": "Ages 12–14 (Grades 7–8)", "segment": "UpperMiddle"},
    {"label": "Ages 14–16 (Grades 9–10)", "segment": "HighSchool"},
    {"label": "Ages 16–18 (Grades 11–12)", "segment": "PreCollege"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB07EFF), Color(0xFF7866FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🧠 Train your brain\nby learning new words',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: segments.length,
                    itemBuilder: (context, index) {
                      final item = segments[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HomeScreen(segment: item['segment']!),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              item['label']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
