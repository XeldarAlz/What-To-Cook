import 'package:http/http.dart' as http;
import 'dart:convert';

class Translator {
  final http.Client client;
  static const String _baseUrl = 'https://api.mymemory.translated.net/get';

  Translator({required this.client});

  Future<String> translateToTurkish(String text) async {
    if (text.isEmpty) return text;
    
    // API limit is 500 characters, split if longer
    const maxLength = 450; // Use 450 to be safe (account for URL encoding)
    
    if (text.length <= maxLength) {
      return await _translateSingleText(text);
    }
    
    // Split long text into chunks and translate separately
    final chunks = <String>[];
    final sentences = text.split(RegExp(r'[.!?]\s+'));
    var currentChunk = '';
    
    for (final sentence in sentences) {
      if ((currentChunk + sentence).length <= maxLength) {
        currentChunk += (currentChunk.isEmpty ? '' : '. ') + sentence;
      } else {
        if (currentChunk.isNotEmpty) {
          chunks.add(currentChunk);
        }
        // If single sentence is too long, split by commas
        if (sentence.length > maxLength) {
          final parts = sentence.split(RegExp(r',\s+'));
          var partChunk = '';
          for (final part in parts) {
            if ((partChunk + part).length <= maxLength) {
              partChunk += (partChunk.isEmpty ? '' : ', ') + part;
            } else {
              if (partChunk.isNotEmpty) chunks.add(partChunk);
              partChunk = part;
            }
          }
          if (partChunk.isNotEmpty) chunks.add(partChunk);
        } else {
          currentChunk = sentence;
        }
      }
    }
    if (currentChunk.isNotEmpty) {
      chunks.add(currentChunk);
    }
    
    // Translate chunks in parallel
    final translatedChunks = await Future.wait(
      chunks.map((chunk) => _translateSingleText(chunk)),
    );
    
    return translatedChunks.join('. ');
  }

  Future<String> _translateSingleText(String text) async {
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
        
        // Check if API returned an error message
        if (translatedText != null && 
            translatedText.isNotEmpty &&
            !translatedText.toUpperCase().contains('QUERY LENGTH LIMIT') &&
            !translatedText.toUpperCase().contains('MAX ALLOWED QUERY')) {
          return translatedText;
        }
      }
      
      // If translation fails, return original text silently
      return text;
    } catch (e) {
      // If translation fails, return original text silently
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

