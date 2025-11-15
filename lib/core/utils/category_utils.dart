import '../../features/recipe/domain/entities/recipe.dart';

/// Category utility functions
/// 
/// This file contains helper functions for working with recipe categories.
class CategoryUtils {
  CategoryUtils._(); // Private constructor to prevent instantiation

  /// Get display name for a recipe category
  static String getCategoryName(RecipeCategory? category) {
    if (category == null) return 'Tümü';
    
    switch (category) {
      case RecipeCategory.kahvalti:
        return 'Kahvaltı';
      case RecipeCategory.ogleYemegi:
        return 'Öğle Yemeği';
      case RecipeCategory.aksamYemegi:
        return 'Akşam Yemeği';
      case RecipeCategory.tatli:
        return 'Tatlı';
    }
  }

  /// Get all available categories
  static List<RecipeCategory> getAllCategories() {
    return RecipeCategory.values;
  }
}

