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
    
    // Translate in parallel batches to improve performance
    // Process in larger batches (10) for better performance
    final translated = <String>[];
    const batchSize = 10;
    
    for (var i = 0; i < items.length; i += batchSize) {
      final batch = items.skip(i).take(batchSize).toList();
      final batchTranslations = await Future.wait(
        batch.map((item) => translateToTurkish(item)),
      );
      translated.addAll(batchTranslations);
      
      // Minimal delay between batches to avoid rate limiting
      if (i + batchSize < items.length) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
    
    return translated;
  }

  Future<String> translateBatchToTurkish(List<String> texts) async {
    if (texts.isEmpty) return '';
    if (texts.length == 1) return await translateToTurkish(texts.first);
    
    // Try to translate multiple texts at once by joining them
    // Some APIs support this, but MyMemory might not
    // For now, translate in parallel
    final translated = await Future.wait(
      texts.map((text) => translateToTurkish(text)),
    );
    
    return translated.join(' ');
  }
}

