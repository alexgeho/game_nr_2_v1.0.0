// 📦 Импорт стандартных библиотек
import 'dart:convert';                    // Для обработки JSON (encode/decode)
import 'package:http/http.dart' as http; // Для отправки HTTP-запросов
import 'package:flutter_dotenv/flutter_dotenv.dart';


// 🚀 Сервис для общения с OpenAI API
class OpenAIService {
  // 🔐 Укажи свой OpenAI API-ключ здесь
static final String apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

  // 🌍 Адрес для POST-запроса к Chat Completions API (GPT)
  static const String endpoint = 'https://api.openai.com/v1/chat/completions';

  /// 📡 Получение уникального слова по категории, избегая уже использованных слов
  static Future<Map<String, dynamic>?> getUniqueWordData(
    String category,
    Set<String> usedWords,
  ) async {
    // 🧠 Составляем промпт для GPT
    final prompt = _buildPrompt(category, usedWords);

    // 🚀 Отправляем POST-запрос в OpenAI
    final response = await http.post(
      Uri.parse(endpoint), // URL-адрес
      headers: {
        'Content-Type': 'application/json',     // Тип передаваемых данных
        'Authorization': 'Bearer $apiKey',      // Авторизация по ключу
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",               // Модель для генерации
        "messages": [
          {
            "role": "user",                    // Роль пользователя
            "content": prompt                  // Промпт, который мы отправляем
          }
        ],
        "temperature": 0.7                     // Температура — креативность
      }),
    );

    // ✅ Если запрос успешен (код 200)
    if (response.statusCode == 200) {
      try {
        // 📥 Расшифровываем тело ответа и извлекаем content (JSON в виде строки)
        final content = jsonDecode(response.body)['choices'][0]['message']['content'];

        // 📤 Преобразуем строку JSON в карту данных (Map)
        return jsonDecode(content);
      } catch (e) {
        // ⚠️ Обработка ошибки JSON
        print('❌ JSON parsing error: $e');
        return null;
      }
    } else {
      // 🧨 Если OpenAI вернул ошибку (например, 401, 429 и т.д.)
      print('❌ OpenAI API error: ${response.statusCode}');
      return null;
    }
  }
  /// 🧠 Генерация промпта на английском языке для GPT
  static String _buildPrompt(String category, Set<String> usedWords) {
    // 🧼 Удаляем пробелы и делаем строчные буквы
    final cleanedCategory = category.trim().toLowerCase();

    // 🚫 Собираем строку из слов, которые нужно исключить
    final exclusions = usedWords.isNotEmpty
        ? 'Do NOT use any of these words: ${usedWords.map((w) => '"$w"').join(', ')}'
        : '';

    // ✍️ Сам промпт, который GPT получит как задачу
    return '''
You are a vocabulary trainer assistant.

Generate a **concrete English noun** related to "$cleanedCategory" and return:
- 5 short hints (useful, descriptive, beginner-friendly)
- A scrambled version of the word

$exclusions

⚠️ Respond only in this exact JSON format:
{
  "word": "example",
  "hints": ["Hint 1", "Hint 2", "Hint 3", "Hint 4", "Hint 5"],
  "scrambled": "elpmaxe"
}

No explanation. No intro. Only valid JSON.
''';
  }
}
