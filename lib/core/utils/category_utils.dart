import '../../features/recipe/domain/entities/recipe.dart';

class CategoryUtils {
  CategoryUtils._();

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

  static List<RecipeCategory> getAllCategories() {
    return RecipeCategory.values;
  }
}

