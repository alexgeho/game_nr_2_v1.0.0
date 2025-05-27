class WordRecord {
  final String word;
  final String category;
  final DateTime timestamp;
  final bool isCorrect;

  WordRecord({
    required this.word,
    required this.category,
    required this.timestamp,
    required this.isCorrect,
  });

  Map<String, dynamic> toJson() => {
    'word': word,
    'category': category,
    'timestamp': timestamp.toIso8601String(),
    'isCorrect': isCorrect,
  };

  factory WordRecord.fromJson(Map<String, dynamic> json) => WordRecord(
    word: json['word'],
    category: json['category'],
    timestamp: DateTime.parse(json['timestamp']),
    isCorrect: json['isCorrect'],
  );
}

class UserProgress {
  final String email;
  final List<WordRecord> history;

  UserProgress({required this.email, required this.history});

  Map<String, dynamic> toJson() => {
    'email': email,
    'history': history.map((h) => h.toJson()).toList(),
  };

  factory UserProgress.fromJson(Map<String, dynamic> json) => UserProgress(
    email: json['email'],
    history: (json['history'] as List)
        .map((h) => WordRecord.fromJson(h))
        .toList(),
  );
}
