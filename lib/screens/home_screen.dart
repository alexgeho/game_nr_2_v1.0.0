// 📁 screens/home_screen.dart
import 'package:flutter/material.dart';
import 'game_screen.dart'; // экран игры

class HomeScreen extends StatelessWidget {
  final String segment; // 🧹 сегмент, переданный с предыдущего экрана

  const HomeScreen({super.key, required this.segment});

  // 📚 Темы по сегментам
  static const Map<String, List<String>> segmentTopics = {
    "Junior1": [
      "Fruits", "Colors", "Animals", "Shapes", "Body Parts", "Clothes", "Numbers", "Toys",
      "Family", "School Supplies", "Vehicles", "Weather", "Food", "Drinks", "Emotions", "Jobs",
      "Nature", "Days of the Week", "Months", "Opposites", "In the House", "Bathroom Items",
      "Kitchen Items", "Pets", "Farm Animals", "Sports", "Musical Instruments", "Things in the Park"
    ],
    "Junior2": [
      "Jobs", "Food", "Transport", "Daily Routines", "Family", "Seasons", "Emotions", "Classroom Items",
      "Hobbies", "Holidays", "Time and Clock", "Shopping", "Sports", "Wild Animals", "Furniture",
      "Rooms in the House", "Clothing Accessories", "Weather Conditions", "Public Places",
      "Means of Communication", "Healthy Habits", "Tools", "Recycling and Waste",
      "Directions and Maps", "Festivals"
    ],
    "Middle": [
      "Countries", "Verbs", "Adjectives", "Nature", "Weather", "Hobbies", "School Subjects", "Time",
      "Continents", "Natural Disasters", "Famous Places", "Inventions", "Daily Activities",
      "Feelings and Moods", "Jobs and Professions", "Materials and Textures", "Technology Devices",
      "Energy Sources", "Environmental Problems", "Comparatives and Superlatives", "Idioms (Simple)",
      "Sports Equipment", "Travel and Tourism", "Important Dates", "Science Tools"
    ],
    "UpperMiddle": [
      "Biology", "Chemistry", "Geography", "Technology", "Physics", "Environment", "Inventions", "Health",
      "Astronomy", "Genetics", "Climate Change", "Famous Scientists", "Ecology", "Renewable Energy",
      "Nutrition", "Anatomy", "Microorganisms", "Chemical Elements", "Space Exploration", "Water Cycle",
      "Forces and Motion", "Lab Safety", "Human Brain", "Historical Discoveries", "Scientific Method"
    ],
    "HighSchool": [
      "Academic English", "TOEFL Prep", "Debates", "Social Issues", "Literature", "Science Terms",
      "Economics", "History", "Philosophy", "Globalization", "Political Systems", "Human Rights",
      "Public Speaking", "Cultural Diversity", "Ethics", "Media Literacy", "Climate Policy",
      "Psychology", "Gender Equality", "Critical Thinking", "Current Events", "Argumentation",
      "Rhetorical Devices", "Sociology", "International Relations"
    ],
    "PreCollege": [
      "Business", "IT", "University Vocabulary", "Finance", "Marketing", "Law", "Artificial Intelligence",
      "Entrepreneurship", "Startups", "Data Science", "Cybersecurity", "Blockchain", "Investment",
      "Project Management", "Leadership", "Machine Learning", "Networking", "Personal Branding",
      "Freelancing", "Innovation", "Econometrics", "Digital Ethics", "Public Relations", "UX/UI Design",
      "Career Planning"
    ]
  };

 @override
  Widget build(BuildContext context) {
    final topics = segmentTopics[segment] ?? [];

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
                  '📚 Choose a topic\nto improve your vocabulary',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                    itemCount: topics.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final topic = topics[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GameScreen(category: topic),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 20),
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
                            topic,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
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