import '../models/ingredient_category.dart';

class IngredientsDataSource {
  static List<IngredientCategory> getCategories() {
    return const [
      IngredientCategory(
        name: 'Sebzeler',
        icon: '🥬',
        items: [
          IngredientItem(turkishName: 'domates', englishName: 'tomato'),
          IngredientItem(turkishName: 'soğan', englishName: 'onion'),
          IngredientItem(turkishName: 'sarımsak', englishName: 'garlic'),
          IngredientItem(turkishName: 'biber', englishName: 'pepper'),
          IngredientItem(turkishName: 'patlıcan', englishName: 'aubergine'),
          IngredientItem(turkishName: 'kabak', englishName: 'zucchini'),
          IngredientItem(turkishName: 'karnabahar', englishName: 'cauliflower'),
          IngredientItem(turkishName: 'pırasa', englishName: 'leek'),
          IngredientItem(turkishName: 'havuç', englishName: 'carrot'),
          IngredientItem(turkishName: 'patates', englishName: 'potato'),
        ],
      ),
      IngredientCategory(
        name: 'Et & Tavuk',
        icon: '🍗',
        items: [
          IngredientItem(turkishName: 'kıyma', englishName: 'beef'),
          IngredientItem(turkishName: 'tavuk', englishName: 'chicken'),
          IngredientItem(turkishName: 'kuzu eti', englishName: 'lamb'),
        ],
      ),
      IngredientCategory(
        name: 'Süt Ürünleri',
        icon: '🥛',
        items: [
          IngredientItem(turkishName: 'peynir', englishName: 'cheese'),
          IngredientItem(turkishName: 'yoğurt', englishName: 'yogurt'),
          IngredientItem(turkishName: 'süt', englishName: 'milk'),
          IngredientItem(turkishName: 'tereyağı', englishName: 'butter'),
        ],
      ),
      IngredientCategory(
        name: 'Temel Malzemeler',
        icon: '🥚',
        items: [
          IngredientItem(turkishName: 'yumurta', englishName: 'egg'),
          IngredientItem(turkishName: 'un', englishName: 'flour'),
          IngredientItem(turkishName: 'makarna', englishName: 'pasta'),
          IngredientItem(turkishName: 'pirinç', englishName: 'rice'),
          IngredientItem(turkishName: 'yufka', englishName: 'phyllo'),
          IngredientItem(turkishName: 'ekmek içi', englishName: 'bread'),
        ],
      ),
      IngredientCategory(
        name: 'Baharat & Soslar',
        icon: '🌶️',
        items: [
          IngredientItem(turkishName: 'zeytinyağı', englishName: 'olive oil'),
          IngredientItem(turkishName: 'maydanoz', englishName: 'parsley'),
          IngredientItem(turkishName: 'fesleğen', englishName: 'basil'),
          IngredientItem(turkishName: 'tuz', englishName: 'salt'),
          IngredientItem(turkishName: 'karabiber', englishName: 'black pepper'),
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

  static String? getEnglishName(String turkishName) {
    final categories = getCategories();
    for (final category in categories) {
      for (final item in category.items) {
        if (item.turkishName.toLowerCase() == turkishName.toLowerCase()) {
          return item.englishName;
        }
      }
    }
    return null;
  }

  static List<String> getEnglishNames(List<String> turkishNames) {
    return turkishNames
        .map((name) => getEnglishName(name))
        .where((name) => name != null)
        .cast<String>()
        .toList();
  }
}

