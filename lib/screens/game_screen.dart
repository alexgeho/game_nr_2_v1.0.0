import 'package:flutter/material.dart';
import 'dart:math';
import '../services/openai_service.dart'; // 🔗 Сервис OpenAI для генерации слов

// 📦 Модель данных одного слова с подсказками
class WordData {
  final String word;              // Само слово
  final String hintMain;         // Основная подсказка
  final List<String> extraHints; // Дополнительные подсказки

  WordData({
    required this.word,
    required this.hintMain,
    required this.extraHints,
  });
}

// 🎮 Экран игры (StatefulWidget)
class GameScreen extends StatefulWidget {
  final String category; // Выбранная категория (например, Fruits)

  const GameScreen({super.key, required this.category});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

// 🧠 Состояние игры
class _GameScreenState extends State<GameScreen> {
  // 🎵 Контроллер для звуков (можно удалить, если не используем)

  // 📘 Контроллер ввода текста
  final TextEditingController controller = TextEditingController();

  // 🔡 Уже угаданные буквы
  final Set<String> usedLetters = {};

  // 📛 Уже использованные слова, чтобы не повторялись
  final Set<String> usedWords = {};

  // 📦 Текущее слово, которое нужно угадать
  late WordData current;

  // 📍 Текущее состояние угадываемого слова
  String guessed = '';


  String message = '';          // Сообщения об успехе/ошибке
  bool showHintOptions = false; // Флаг показа кнопок подсказок
  bool gameEnded = false;       // Флаг окончания игры

  int attempts = 0;             // Количество попыток
  int extraHintCount = 0;       // Сколько дополнительных подсказок показано
  bool scrambledUsed = false;   // Использовалась ли перемешанная подсказка

  final int maxAttempts = 10;   // Максимальное число попыток
  List<String> revealedHints = []; // Список показанных подсказок

  // 🚀 Первичная инициализация состояния
  @override
  void initState() {
    super.initState();
    usedWords.clear();   // Очищаем историю слов при запуске
    _loadNewWord();      // Загружаем первое слово
  }

  // 🔁 Запрос нового уникального слова из OpenAI
  Future<void> _loadNewWord() async {
    final response = await OpenAIService.getUniqueWordData(widget.category, usedWords);
    final newWord = response?['word']?.toLowerCase();

    if (response != null && newWord != null) {
      usedWords.add(newWord);
      setState(() {
        current = WordData(
          word: newWord,
          hintMain: response['hints'][0],
          extraHints: List<String>.from(response['hints'].skip(1)),
        );
        guessed = List.filled(current.word.length, '_').join(' ');
        usedLetters.clear();
        attempts = 0;
        extraHintCount = 0;
        scrambledUsed = false;
        message = '';
        revealedHints.clear();
        gameEnded = false;
        controller.clear();
      });
    } else {
      setState(() {
        message = '⚠️ Could not load a word. Try again.';
      });
    }
  }

  // 🔤 Обработка пользовательского ввода (буква, слово или "hint")
  void _handleInput(String input) {
    input = input.trim().toLowerCase();
    setState(() {
      if (input == 'hint') {
        showHintOptions = true;
      } else if (input.length > 1) {
        // Полное слово
        if (input == current.word.toLowerCase()) {
          guessed = current.word.split('').join(' ');
          message = '🎉 You guessed it! The word was "${current.word}"';
          gameEnded = true;
        } else {
          attempts++;
          message = 'Wrong word. Attempts left: ${maxAttempts - attempts}';
        }
      } else if (input.length == 1) {
        // Одиночная буква
        usedLetters.add(input);
        bool found = false;
        List<String> chars = guessed.split(' ');
        for (int i = 0; i < current.word.length; i++) {
          if (current.word[i].toLowerCase() == input) {
            chars[i] = current.word[i]; // сохраняем оригинальную букву
            found = true;
          }
        }
        guessed = chars.join(' ');

        
        if (!found) {
  attempts++;
  message = 'No such letter. Attempts left: ${maxAttempts - attempts}';
} else {
  message = ''; // не показываем сообщение при правильной букве
}

      }

      // ✅ Проверка победы/поражения
      if (guessed.replaceAll(' ', '') == current.word) {
        message = '🎉 You guessed it! The word was "${current.word}"';
        gameEnded = true;
      } else if (attempts >= maxAttempts) {
        message = '🌟 Out of attempts. The word was: "${current.word}"';
        guessed = current.word.split('').join(' ');
        gameEnded = true;
      }

      controller.clear(); // очистка ввода
    });
  }

  

  // 🔀 Показываем перемешанное слово
 // 🔀 Показываем перемешанное слово
void _showScrambledHint() {
  if (!scrambledUsed) {
    final scrambled = current.word.split('')..shuffle();
    setState(() {
      revealedHints.add("Scrambled word: ${scrambled.join()}");
      scrambledUsed = true;
    });
  }

  _checkIfAllHintsUsed(); // ✅ Добавляем универсальную проверку
}

// 💡 Показываем дополнительную подсказку
void _showExtraHint() {
  if (extraHintCount < current.extraHints.length) {
    setState(() {
      revealedHints.add("Hint: ${current.extraHints[extraHintCount]}");
      extraHintCount++;
    });
  }

  _checkIfAllHintsUsed(); // ✅ Добавляем универсальную проверку
}

// ✅ Универсальная проверка — были ли использованы все подсказки
void _checkIfAllHintsUsed() {
  if (!gameEnded &&
      extraHintCount >= current.extraHints.length &&
      scrambledUsed) {
    setState(() {
      message =
          '🌟 All hints used. Well done for not giving up!\nThe word was: "${current.word}"';
      guessed = current.word.split('').join(' ');
      gameEnded = true;
    });
  }
}




  // 🧹 Очистка ресурсов при выходе
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

Widget _buildCard(String label, String content, {Color color = Colors.black87}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          content,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    ),
  );
}



Widget _customButton(String text, VoidCallback onPressed, {bool big = false}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFF7866FF),
      padding: EdgeInsets.symmetric(
        horizontal: big ? 32 : 20,
        vertical: big ? 16 : 12,
      ),
      textStyle: TextStyle(
        fontSize: big ? 18 : 14,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      elevation: 3,
    ),
    child: Text(text),
  );
}






  // 🖼️ Основной UI игры
  
@override
Widget build(BuildContext context) {
  if (guessed.isEmpty || current.word.isEmpty) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  return Scaffold(

appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Color(0xFF7866FF)),
    onPressed: () => Navigator.pop(context),
  ),
  title: const Text(
    'Back to categories',
    style: TextStyle(
      color: Color(0xFF7866FF),
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
  ),
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
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🧩 Let’s guess the word!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
               
_buildCard(
  "Hint",
  [
    current.hintMain,
    ...revealedHints,
  ].join('\n'),
),


                const SizedBox(height: 16),
                _buildCard("Word", guessed),
                const SizedBox(height: 10),
                if (message.isNotEmpty)
                  _buildCard("Feedback", message, color: Colors.green),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: controller,
                    onSubmitted: _handleInput,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Enter letter, word, or "hint"',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _customButton('Hint Options', () {
                      setState(() => showHintOptions = !showHintOptions);
                    }),
                    if (showHintOptions || gameEnded)
                      _customButton('Extra Hint', _showExtraHint),
                    if (showHintOptions || gameEnded)
                      _customButton('Scrambled', _showScrambledHint),
                      
                    if (gameEnded)
  Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: _customButton('Play Again', _loadNewWord, big: true),
  ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}


}
