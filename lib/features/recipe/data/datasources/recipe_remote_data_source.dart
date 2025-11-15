import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/error/failures.dart';
import '../../../../core/network/translator.dart';
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
  final Translator translator;
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  RecipeRemoteDataSourceImpl({
    required this.client,
    required this.translator,
  });

  @override
  Future<RecipeModel> getRecipeFromWebsite(String recipeName) async {
    try {
      final searchUrl =
          '$_baseUrl/search.php?s=${Uri.encodeComponent(recipeName)}';
      final response = await client.get(Uri.parse(searchUrl));

      if (response.statusCode != 200) {
        throw ServerFailure('Failed to fetch recipe');
      }

      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final meals = jsonData['meals'] as List<dynamic>?;

      if (meals == null || meals.isEmpty) {
        throw NotFoundFailure('Recipe not found: $recipeName');
      }

      return await _parseMealToRecipe(meals.first as Map<String, dynamic>);
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure('Error fetching recipe: ${e.toString()}');
    }
  }

  @override
  Future<RecipeModel> getRandomRecipeFromWebsite() async {
    try {
      final randomUrl = '$_baseUrl/random.php';
      final response = await client.get(Uri.parse(randomUrl));

      if (response.statusCode != 200) {
        throw ServerFailure('Failed to fetch random recipe');
      }

      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final meals = jsonData['meals'] as List<dynamic>?;

      if (meals == null || meals.isEmpty) {
        throw NotFoundFailure('No random recipe found');
      }

      return await _parseMealToRecipe(meals.first as Map<String, dynamic>);
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

      // TheMealDB API accepts one ingredient at a time for filtering
      // Try multiple ingredients and combine results
      final allMealIds = <String>{};
      
      // Search with each ingredient and collect meal IDs
      for (final ingredient in ingredients.take(3)) {
        // Limit to first 3 ingredients to avoid too many API calls
        try {
          final ingredientFormatted = ingredient.toLowerCase().replaceAll(' ', '_');
          final filterUrl = '$_baseUrl/filter.php?i=$ingredientFormatted';
          final response = await client.get(Uri.parse(filterUrl));

          if (response.statusCode == 200) {
            final jsonData = json.decode(response.body) as Map<String, dynamic>;
            final meals = jsonData['meals'] as List<dynamic>?;

            if (meals != null && meals.isNotEmpty) {
              for (final meal in meals) {
                final mealId = (meal as Map<String, dynamic>)['idMeal'] as String;
                allMealIds.add(mealId);
              }
            }
          }
        } catch (e) {
          // Continue with next ingredient if one fails
          continue;
        }
      }

      if (allMealIds.isEmpty) {
        return [];
      }

      // Fetch details for meals and filter by all ingredients
      final recipes = <RecipeModel>[];
      final mealIdsList = allMealIds.toList();
      final maxRecipes = mealIdsList.length > 10 ? 10 : mealIdsList.length;

      for (var i = 0; i < maxRecipes; i++) {
        try {
          final mealId = mealIdsList[i];
          final detailUrl = '$_baseUrl/lookup.php?i=$mealId';
          final detailResponse = await client.get(Uri.parse(detailUrl));

          if (detailResponse.statusCode == 200) {
            final detailData =
                json.decode(detailResponse.body) as Map<String, dynamic>;
            final detailMeals = detailData['meals'] as List<dynamic>?;

            if (detailMeals != null && detailMeals.isNotEmpty) {
              final mealData = detailMeals.first as Map<String, dynamic>;
              
              // Check if meal contains any of the requested ingredients
              bool containsIngredient = false;
              for (var j = 1; j <= 20; j++) {
                final mealIngredient = mealData['strIngredient$j'] as String?;
                if (mealIngredient != null && mealIngredient.isNotEmpty) {
                  final mealIngredientLower = mealIngredient.toLowerCase();
                  if (ingredients.any((ing) => 
                      mealIngredientLower.contains(ing.toLowerCase()) ||
                      ing.toLowerCase().contains(mealIngredientLower))) {
                    containsIngredient = true;
                    break;
                  }
                }
              }

              if (containsIngredient) {
                final recipe = await _parseMealToRecipe(mealData);
                recipes.add(recipe);
                
                // Limit to 5 recipes for performance
                if (recipes.length >= 5) {
                  break;
                }
              }
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

  Future<RecipeModel> _parseMealToRecipe(Map<String, dynamic> meal) async {
    // Extract ingredients and measures
    final ingredients = <String>[];
    for (var i = 1; i <= 20; i++) {
      final ingredient = meal['strIngredient$i'] as String?;
      final measure = meal['strMeasure$i'] as String?;

      if (ingredient != null && ingredient.isNotEmpty) {
        final ingredientText = measure != null && measure.isNotEmpty
            ? '$measure $ingredient'
            : ingredient;
        ingredients.add(ingredientText.trim());
      }
    }

    // Extract instructions and split by newlines or numbers
    final instructionsText = meal['strInstructions'] as String? ?? '';
    final instructions = <String>[];

    if (instructionsText.isNotEmpty) {
      // Split by numbered steps or newlines
      final lines = instructionsText
          .split(RegExp(r'\n+|\d+\.'))
          .map((line) => line.trim())
          .where((line) => line.isNotEmpty)
          .toList();

      if (lines.isNotEmpty) {
        instructions.addAll(lines);
      } else {
        // If no clear separation, use the whole text
        instructions.add(instructionsText);
      }
    }

    // Translate to Turkish in parallel for better performance
    final name = meal['strMeal'] as String? ?? 'Unknown Recipe';
    final category = meal['strCategory'] as String? ?? '';
    final area = meal['strArea'] as String? ?? '';
    
    // Translate name, category, and area in parallel
    final nameCategoryAreaTranslations = await Future.wait([
      translator.translateToTurkish(name),
      category.isNotEmpty ? translator.translateToTurkish(category) : Future.value(''),
      area.isNotEmpty ? translator.translateToTurkish(area) : Future.value(''),
    ]);
    
    final translatedName = nameCategoryAreaTranslations[0];
    final translatedCategory = nameCategoryAreaTranslations[1];
    final translatedArea = nameCategoryAreaTranslations[2];
    
    final description = category.isNotEmpty
        ? '$translatedCategory${area.isNotEmpty ? ' - $translatedArea' : ''}'
        : '';
    
    // Optimize instruction translation: if instructions are long, 
    // translate as a single text for better performance
    final List<String> translatedInstructions;
    if (instructions.isEmpty) {
      translatedInstructions = ['Tarif detayları bulunamadı'];
    } else if (instructions.length <= 3) {
      // Short instructions: translate individually for better quality
      translatedInstructions = await translator.translateListToTurkish(instructions);
    } else {
      // Long instructions: join and translate as one text for speed
      final joinedInstructions = instructions.join('\n');
      final translatedText = await translator.translateToTurkish(joinedInstructions);
      // Split back by newlines or periods
      final splitInstructions = translatedText
          .split(RegExp(r'\n+|\.\s+'))
          .map((line) => line.trim())
          .where((line) => line.isNotEmpty)
          .toList();
      translatedInstructions = splitInstructions.isEmpty 
          ? [translatedText] 
          : splitInstructions;
    }
    
    // Translate ingredients in parallel with instructions
    final translatedIngredients = await translator.translateListToTurkish(ingredients);

    return RecipeModel(
      id: meal['idMeal'] as String? ?? '',
      name: translatedName,
      description: description,
      imageUrl: meal['strMealThumb'] as String? ?? '',
      ingredients: translatedIngredients,
      instructions: translatedInstructions,
    );
  }
}
