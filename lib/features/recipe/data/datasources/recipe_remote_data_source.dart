import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'dart:math';
import '../../../../core/error/failures.dart';
import '../models/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<RecipeModel> getRecipeFromWebsite(String recipeName);
  Future<RecipeModel> getRandomRecipeFromWebsite();
  Future<List<RecipeModel>> getRecipesByIngredientsFromWebsite(
    List<String> ingredients,
  );
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;

  RecipeRemoteDataSourceImpl({required this.client});

  @override
  Future<RecipeModel> getRecipeFromWebsite(String recipeName) async {
    try {
      // Search for recipe on nefisyemektarifleri.com
      final searchUrl =
          'https://www.nefisyemektarifleri.com/?s=${Uri.encodeComponent(recipeName)}';
      final searchResponse = await client.get(Uri.parse(searchUrl));

      if (searchResponse.statusCode != 200) {
        throw ServerFailure('Failed to fetch recipe');
      }

      final searchDocument = html_parser.parse(searchResponse.body);
      final recipeLinks = searchDocument.querySelectorAll('a.entry-title-link');

      if (recipeLinks.isEmpty) {
        throw NotFoundFailure('Recipe not found');
      }

      // Get first recipe link
      final recipeUrl = recipeLinks.first.attributes['href'];
      if (recipeUrl == null) {
        throw NotFoundFailure('Recipe URL not found');
      }

      // Fetch recipe details
      final recipeResponse = await client.get(Uri.parse(recipeUrl));
      if (recipeResponse.statusCode != 200) {
        throw ServerFailure('Failed to fetch recipe details');
      }

      final recipeDocument = html_parser.parse(recipeResponse.body);

      // Extract recipe data
      final title =
          recipeDocument.querySelector('h1.entry-title')?.text ?? recipeName;
      final description =
          recipeDocument.querySelector('.entry-content p')?.text ?? '';

      // Extract image
      final imageElement = recipeDocument.querySelector('.entry-content img');
      final imageUrl = imageElement?.attributes['src'] ?? '';

      // Extract ingredients
      final ingredients = <String>[];
      final ingredientElements = recipeDocument.querySelectorAll(
        '.malzemeler li, .ingredients li',
      );
      for (var element in ingredientElements) {
        final text = element.text.trim();
        if (text.isNotEmpty) {
          ingredients.add(text);
        }
      }

      // Extract instructions
      final instructions = <String>[];
      final instructionElements = recipeDocument.querySelectorAll(
        '.tarif li, .instructions li, .yapilis li',
      );
      for (var element in instructionElements) {
        final text = element.text.trim();
        if (text.isNotEmpty) {
          instructions.add(text);
        }
      }

      // If no structured data found, try to extract from content
      if (ingredients.isEmpty || instructions.isEmpty) {
        final content = recipeDocument.querySelector('.entry-content');
        if (content != null) {
          final paragraphs = content.querySelectorAll('p');
          for (var p in paragraphs) {
            final text = p.text.trim();
            if (text.toLowerCase().contains('malzeme') ||
                text.toLowerCase().contains('gerekli')) {
              // Try to extract ingredients from text
            } else if (text.toLowerCase().contains('yapılış') ||
                text.toLowerCase().contains('hazırlanış')) {
              // Try to extract instructions from text
            }
          }
        }
      }

      return RecipeModel(
        id: recipeUrl,
        name: title,
        description: description,
        imageUrl: imageUrl,
        ingredients: ingredients.isEmpty
            ? ['Malzeme bilgisi bulunamadı']
            : ingredients,
        instructions: instructions.isEmpty
            ? ['Tarif detayları bulunamadı']
            : instructions,
      );
    } catch (e) {
      throw ServerFailure('Error fetching recipe: ${e.toString()}');
    }
  }

  @override
  Future<RecipeModel> getRandomRecipeFromWebsite() async {
    try {
      // Get popular/trending recipes page
      final popularUrl = 'https://www.nefisyemektarifleri.com/trend/';
      final response = await client.get(Uri.parse(popularUrl));

      if (response.statusCode != 200) {
        throw ServerFailure('Failed to fetch recipes');
      }

      final document = html_parser.parse(response.body);
      final recipeLinks = document.querySelectorAll(
        'a.entry-title-link, a[href*="/tarif/"]',
      );

      if (recipeLinks.isEmpty) {
        // Fallback: try main page
        final mainPageResponse = await client.get(
          Uri.parse('https://www.nefisyemektarifleri.com/'),
        );
        if (mainPageResponse.statusCode != 200) {
          throw ServerFailure('Failed to fetch recipes');
        }
        final mainDocument = html_parser.parse(mainPageResponse.body);
        final mainRecipeLinks = mainDocument.querySelectorAll(
          'a.entry-title-link, a[href*="/tarif/"]',
        );

        if (mainRecipeLinks.isEmpty) {
          throw NotFoundFailure('No recipes found');
        }

        final randomLink =
            mainRecipeLinks[Random().nextInt(mainRecipeLinks.length)];
        final recipeUrl = randomLink.attributes['href'];
        if (recipeUrl == null) {
          throw NotFoundFailure('Recipe URL not found');
        }
        return await _fetchRecipeDetails(recipeUrl);
      }

      // Select random recipe from popular recipes
      final randomLink = recipeLinks[Random().nextInt(recipeLinks.length)];
      final recipeUrl = randomLink.attributes['href'];
      if (recipeUrl == null) {
        throw NotFoundFailure('Recipe URL not found');
      }

      return await _fetchRecipeDetails(recipeUrl);
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure('Error fetching random recipe: ${e.toString()}');
    }
  }

  @override
  Future<List<RecipeModel>> getRecipesByIngredientsFromWebsite(
    List<String> ingredients,
  ) async {
    try {
      if (ingredients.isEmpty) {
        return [];
      }

      // Create search query from ingredients
      final searchQuery = ingredients.join(' ');
      final searchUrl =
          'https://www.nefisyemektarifleri.com/?s=${Uri.encodeComponent(searchQuery)}';
      final searchResponse = await client.get(Uri.parse(searchUrl));

      if (searchResponse.statusCode != 200) {
        throw ServerFailure('Failed to search recipes');
      }

      final searchDocument = html_parser.parse(searchResponse.body);
      final recipeLinks = searchDocument.querySelectorAll('a.entry-title-link');

      if (recipeLinks.isEmpty) {
        return [];
      }

      // Fetch first few recipes (limit to 5 for performance)
      final recipes = <RecipeModel>[];
      final maxRecipes = recipeLinks.length > 5 ? 5 : recipeLinks.length;

      for (var i = 0; i < maxRecipes; i++) {
        try {
          final recipeUrl = recipeLinks[i].attributes['href'];
          if (recipeUrl != null) {
            final recipe = await _fetchRecipeDetails(recipeUrl);
            // Check if recipe contains at least one of the ingredients
            final recipeIngredientsLower = recipe.ingredients
                .map((ing) => ing.toLowerCase())
                .join(' ');
            final hasIngredient = ingredients.any(
              (ing) => recipeIngredientsLower.contains(ing.toLowerCase()),
            );

            if (hasIngredient) {
              recipes.add(recipe);
            }
          }
        } catch (e) {
          // Skip failed recipes
          continue;
        }
      }

      return recipes;
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure(
        'Error searching recipes by ingredients: ${e.toString()}',
      );
    }
  }

  Future<RecipeModel> _fetchRecipeDetails(String recipeUrl) async {
    // Ensure URL is absolute
    final fullUrl = recipeUrl.startsWith('http')
        ? recipeUrl
        : 'https://www.nefisyemektarifleri.com$recipeUrl';

    final recipeResponse = await client.get(Uri.parse(fullUrl));
    if (recipeResponse.statusCode != 200) {
      throw ServerFailure('Failed to fetch recipe details');
    }

    final recipeDocument = html_parser.parse(recipeResponse.body);

    // Extract recipe data
    final title =
        recipeDocument.querySelector('h1.entry-title')?.text ??
        recipeDocument.querySelector('h1')?.text ??
        'Tarif';
    final description =
        recipeDocument.querySelector('.entry-content p')?.text ??
        recipeDocument.querySelector('.entry-excerpt')?.text ??
        '';

    // Extract image
    final imageElement = recipeDocument.querySelector(
      '.entry-content img, .recipe-image img, img.wp-post-image',
    );
    final imageUrl =
        imageElement?.attributes['src'] ??
        imageElement?.attributes['data-src'] ??
        '';

    // Extract ingredients
    final ingredients = <String>[];
    final ingredientElements = recipeDocument.querySelectorAll(
      '.malzemeler li, .ingredients li, .recipe-ingredients li, ul.malzemeler li',
    );
    for (var element in ingredientElements) {
      final text = element.text.trim();
      if (text.isNotEmpty && !text.toLowerCase().contains('malzeme')) {
        ingredients.add(text);
      }
    }

    // Extract instructions
    final instructions = <String>[];
    final instructionElements = recipeDocument.querySelectorAll(
      '.tarif li, .instructions li, .yapilis li, .recipe-steps li, ol.tarif li, ul.tarif li',
    );
    for (var element in instructionElements) {
      final text = element.text.trim();
      if (text.isNotEmpty && !text.toLowerCase().contains('yapılış')) {
        instructions.add(text);
      }
    }

    // If no structured data found, try to extract from content paragraphs
    if (ingredients.isEmpty || instructions.isEmpty) {
      final content = recipeDocument.querySelector('.entry-content');
      if (content != null) {
        final paragraphs = content.querySelectorAll('p');
        bool inIngredientsSection = false;
        bool inInstructionsSection = false;

        for (var p in paragraphs) {
          final text = p.text.trim();
          final lowerText = text.toLowerCase();

          if (lowerText.contains('malzeme') || lowerText.contains('gerekli')) {
            inIngredientsSection = true;
            inInstructionsSection = false;
            continue;
          } else if (lowerText.contains('yapılış') ||
              lowerText.contains('hazırlanış') ||
              lowerText.contains('tarif')) {
            inIngredientsSection = false;
            inInstructionsSection = true;
            continue;
          }

          if (inIngredientsSection &&
              text.isNotEmpty &&
              ingredients.length < 20) {
            ingredients.add(text);
          } else if (inInstructionsSection &&
              text.isNotEmpty &&
              instructions.length < 20) {
            instructions.add(text);
          }
        }
      }
    }

    return RecipeModel(
      id: fullUrl,
      name: title,
      description: description,
      imageUrl: imageUrl,
      ingredients: ingredients.isEmpty
          ? ['Malzeme bilgisi bulunamadı']
          : ingredients,
      instructions: instructions.isEmpty
          ? ['Tarif detayları bulunamadı']
          : instructions,
    );
  }
}
