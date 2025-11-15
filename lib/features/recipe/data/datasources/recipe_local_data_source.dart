import '../../domain/entities/recipe.dart';
import '../models/recipe_model.dart';
import '../models/recipes_data.dart';

abstract class RecipeLocalDataSource {
  List<RecipeModel> getAllRecipes();
  List<RecipeModel> getRecipesByCategory(RecipeCategory category);
  RecipeModel? getRecipeById(String id);
  RecipeModel getRandomRecipeByCategory(RecipeCategory category, List<String> excludeIds);
}

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  List<RecipeModel> get _recipes => RecipesData.getAllRecipes();
  @override
  List<RecipeModel> getAllRecipes() {
    return List.unmodifiable(_recipes);
  }

  @override
  List<RecipeModel> getRecipesByCategory(RecipeCategory category) {
    return _recipes.where((recipe) => recipe.category == category).toList();
  }

  @override
  RecipeModel? getRecipeById(String id) {
    try {
      return _recipes.firstWhere((recipe) => recipe.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  RecipeModel getRandomRecipeByCategory(
    RecipeCategory category,
    List<String> excludeIds,
  ) {
    final availableRecipes = getRecipesByCategory(category)
        .where((recipe) => !excludeIds.contains(recipe.id))
        .toList();
    
    if (availableRecipes.isEmpty) {
      // If all recipes shown, reset and return random
      final allRecipes = getRecipesByCategory(category);
      return allRecipes[DateTime.now().millisecond % allRecipes.length];
    }
    
    return availableRecipes[DateTime.now().millisecond % availableRecipes.length];
  }
}

