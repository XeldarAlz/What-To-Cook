import '../models/ingredient_category.dart';

class IngredientsDataSource {
  static List<IngredientCategory> getCategories() {
    return const [
      IngredientCategory(
        name: 'Sebzeler',
        icon: '🥬',
        items: [
          IngredientItem(turkishName: 'domates'),
          IngredientItem(turkishName: 'soğan'),
          IngredientItem(turkishName: 'sarımsak'),
          IngredientItem(turkishName: 'biber'),
          IngredientItem(turkishName: 'patlıcan'),
          IngredientItem(turkishName: 'kabak'),
          IngredientItem(turkishName: 'karnabahar'),
          IngredientItem(turkishName: 'pırasa'),
          IngredientItem(turkishName: 'havuç'),
          IngredientItem(turkishName: 'patates'),
        ],
      ),
      IngredientCategory(
        name: 'Et & Tavuk',
        icon: '🍗',
        items: [
          IngredientItem(turkishName: 'kıyma'),
          IngredientItem(turkishName: 'tavuk'),
          IngredientItem(turkishName: 'kuzu eti'),
        ],
      ),
      IngredientCategory(
        name: 'Süt Ürünleri',
        icon: '🥛',
        items: [
          IngredientItem(turkishName: 'peynir'),
          IngredientItem(turkishName: 'yoğurt'),
          IngredientItem(turkishName: 'süt'),
          IngredientItem(turkishName: 'tereyağı'),
        ],
      ),
      IngredientCategory(
        name: 'Temel Malzemeler',
        icon: '🥚',
        items: [
          IngredientItem(turkishName: 'yumurta'),
          IngredientItem(turkishName: 'un'),
          IngredientItem(turkishName: 'makarna'),
          IngredientItem(turkishName: 'pirinç'),
          IngredientItem(turkishName: 'yufka'),
          IngredientItem(turkishName: 'ekmek içi'),
        ],
      ),
      IngredientCategory(
        name: 'Baharat & Soslar',
        icon: '🌶️',
        items: [
          IngredientItem(turkishName: 'zeytinyağı'),
          IngredientItem(turkishName: 'maydanoz'),
          IngredientItem(turkishName: 'fesleğen'),
          IngredientItem(turkishName: 'tuz'),
          IngredientItem(turkishName: 'karabiber'),
        ],
      ),
    ];
  }

  static List<String> getAllTurkishNames() {
    final categories = getCategories();
    return categories
        .expand((category) => category.items.map((item) => item.turkishName))
        .toList();
  }
}

