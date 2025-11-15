import 'package:http/http.dart' as http;
import 'dart:convert';

class Translator {
  final http.Client client;
  static const String _baseUrl = 'https://api.mymemory.translated.net/get';

  Translator({required this.client});

  Future<String> translateToTurkish(String text) async {
    if (text.isEmpty) return text;
    
    try {
      final url = Uri.parse(
        '$_baseUrl?q=${Uri.encodeComponent(text)}&langpair=en|tr',
      );
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        final responseData = jsonData['responseData'] as Map<String, dynamic>?;
        final translatedText = responseData?['translatedText'] as String?;
        
        if (translatedText != null && translatedText.isNotEmpty) {
          return translatedText;
        }
      }
      
      // If translation fails, return original text
      return text;
    } catch (e) {
      // If translation fails, return original text
      return text;
    }
  }

  Future<List<String>> translateListToTurkish(List<String> items) async {
    if (items.isEmpty) return items;
    
    final translated = <String>[];
    for (final item in items) {
      final translatedItem = await translateToTurkish(item);
      translated.add(translatedItem);
      // Small delay to avoid rate limiting
      await Future.delayed(const Duration(milliseconds: 100));
    }
    
    return translated;
  }
}

