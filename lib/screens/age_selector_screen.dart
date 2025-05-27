import 'package:flutter/material.dart';
import 'home_screen.dart';

class AgeSelectorScreen extends StatelessWidget {
  const AgeSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> segments = const [
      {"label": "Ages 6–8 (Grades 1–2)", "segment": "Junior1"},
      {"label": "Ages 8–10 (Grades 3–4)", "segment": "Junior2"},
      {"label": "Ages 10–12 (Grades 5–6)", "segment": "Middle"},
      {"label": "Ages 12–14 (Grades 7–8)", "segment": "UpperMiddle"},
      {"label": "Ages 14–16 (Grades 9–10)", "segment": "HighSchool"},
      {"label": "Ages 16–18 (Grades 11–12)", "segment": "PreCollege"},
    ];

    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color(0xFFF7F1FF),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Color(0xFF7866FF),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Menu',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('History'),
              onTap: () {
                Navigator.pushNamed(context, '/history');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('FAQ'),
              onTap: () {
                Navigator.pushNamed(context, '/faq');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log In'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB07EFF),
        title: const Text('🧠 Train your brain\nby learning new words',
            style: TextStyle(fontSize: 18)),
        centerTitle: false,
        elevation: 0,
      ),
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
              children: [
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
                                builder: (_) =>
                                    HomeScreen(segment: item['segment']!),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 16),
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
