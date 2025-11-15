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
          IngredientItem(turkishName: 'brokoli'),
          IngredientItem(turkishName: 'ıspanak'),
          IngredientItem(turkishName: 'lahana'),
          IngredientItem(turkishName: 'kırmızı biber'),
          IngredientItem(turkishName: 'yeşil fasulye'),
          IngredientItem(turkishName: 'bezelye'),
          IngredientItem(turkishName: 'mantar'),
          IngredientItem(turkishName: 'taze fasulye'),
          IngredientItem(turkishName: 'bamya'),
          IngredientItem(turkishName: 'salatalık'),
          IngredientItem(turkishName: 'marul'),
          IngredientItem(turkishName: 'roka'),
          IngredientItem(turkishName: 'dereotu'),
          IngredientItem(turkishName: 'nane'),
          IngredientItem(turkishName: 'maydanoz'),
        ],
      ),
      IngredientCategory(
        name: 'Et & Tavuk',
        icon: '🍗',
        items: [
          IngredientItem(turkishName: 'kıyma'),
          IngredientItem(turkishName: 'tavuk'),
          IngredientItem(turkishName: 'kuzu eti'),
          IngredientItem(turkishName: 'dana eti'),
          IngredientItem(turkishName: 'hindi'),
          IngredientItem(turkishName: 'sucuk'),
          IngredientItem(turkishName: 'pastırma'),
          IngredientItem(turkishName: 'sosis'),
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
          IngredientItem(turkishName: 'lor peyniri'),
          IngredientItem(turkishName: 'kaşar peyniri'),
          IngredientItem(turkishName: 'beyaz peynir'),
          IngredientItem(turkishName: 'krema'),
          IngredientItem(turkishName: 'ayran'),
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
          IngredientItem(turkishName: 'bulgur'),
          IngredientItem(turkishName: 'mercimek'),
          IngredientItem(turkishName: 'nohut'),
          IngredientItem(turkishName: 'fasulye'),
          IngredientItem(turkishName: 'şehriye'),
          IngredientItem(turkishName: 'erişte'),
          IngredientItem(turkishName: 'börek yufkası'),
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
          IngredientItem(turkishName: 'kırmızı biber'),
          IngredientItem(turkishName: 'kimyon'),
          IngredientItem(turkishName: 'zerdeçal'),
          IngredientItem(turkishName: 'nane'),
          IngredientItem(turkishName: 'kekik'),
          IngredientItem(turkishName: 'sumak'),
          IngredientItem(turkishName: 'limon'),
          IngredientItem(turkishName: 'sirke'),
          IngredientItem(turkishName: 'salça'),
          IngredientItem(turkishName: 'domates salçası'),
          IngredientItem(turkishName: 'biber salçası'),
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

