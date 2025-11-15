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
          IngredientItem(turkishName: 'yeşil biber'),
          IngredientItem(turkishName: 'kırmızı biber'),
          IngredientItem(turkishName: 'patlıcan'),
          IngredientItem(turkishName: 'kabak'),
          IngredientItem(turkishName: 'patates'),
          IngredientItem(turkishName: 'havuç'),
          IngredientItem(turkishName: 'pırasa'),
          IngredientItem(turkishName: 'karnabahar'),
          IngredientItem(turkishName: 'ıspanak'),
          IngredientItem(turkishName: 'lahana'),
          IngredientItem(turkishName: 'brokoli'),
          IngredientItem(turkishName: 'mantar'),
          IngredientItem(turkishName: 'taze fasulye'),
          IngredientItem(turkishName: 'bezelye'),
          IngredientItem(turkishName: 'bamya'),
          IngredientItem(turkishName: 'salatalık'),
          IngredientItem(turkishName: 'marul'),
          IngredientItem(turkishName: 'maydanoz'),
          IngredientItem(turkishName: 'dereotu'),
          IngredientItem(turkishName: 'nane'),
        ],
      ),
      IngredientCategory(
        name: 'Et & Tavuk',
        icon: '🍗',
        items: [
          IngredientItem(turkishName: 'kıyma'),
          IngredientItem(turkishName: 'tavuk'),
          IngredientItem(turkishName: 'dana eti'),
          IngredientItem(turkishName: 'kuşbaşı et'),
          IngredientItem(turkishName: 'kuzu eti'),
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
          IngredientItem(turkishName: 'beyaz peynir'),
          IngredientItem(turkishName: 'kaşar peyniri'),
          IngredientItem(turkishName: 'lor peyniri'),
          IngredientItem(turkishName: 'tuzsuz peynir'),
          IngredientItem(turkishName: 'yoğurt'),
          IngredientItem(turkishName: 'süt'),
          IngredientItem(turkishName: 'tereyağı'),
          IngredientItem(turkishName: 'margarin'),
          IngredientItem(turkishName: 'kaymak'),
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
          IngredientItem(turkishName: 'ekmek'),
          IngredientItem(turkishName: 'ekmek içi'),
          IngredientItem(turkishName: 'lavaş ekmeği'),
          IngredientItem(turkishName: 'yufka'),
          IngredientItem(turkishName: 'börek yufkası'),
          IngredientItem(turkishName: 'maya'),
          IngredientItem(turkishName: 'şeker'),
          IngredientItem(turkishName: 'tuz'),
          IngredientItem(turkishName: 'pirinç'),
          IngredientItem(turkishName: 'bulgur'),
          IngredientItem(turkishName: 'mercimek'),
          IngredientItem(turkishName: 'nohut'),
          IngredientItem(turkishName: 'fasulye'),
          IngredientItem(turkishName: 'makarna'),
          IngredientItem(turkishName: 'şehriye'),
          IngredientItem(turkishName: 'erişte'),
          IngredientItem(turkishName: 'tel kadayıf'),
          IngredientItem(turkishName: 'ceviz'),
          IngredientItem(turkishName: 'vanilya'),
        ],
      ),
      IngredientCategory(
        name: 'Baharat & Soslar',
        icon: '🌶️',
        items: [
          IngredientItem(turkishName: 'zeytinyağı'),
          IngredientItem(turkishName: 'karabiber'),
          IngredientItem(turkishName: 'kimyon'),
          IngredientItem(turkishName: 'kekik'),
          IngredientItem(turkishName: 'nane'),
          IngredientItem(turkishName: 'sumak'),
          IngredientItem(turkishName: 'zerdeçal'),
          IngredientItem(turkishName: 'salça'),
          IngredientItem(turkishName: 'domates salçası'),
          IngredientItem(turkishName: 'biber salçası'),
          IngredientItem(turkishName: 'limon'),
          IngredientItem(turkishName: 'sirke'),
          IngredientItem(turkishName: 'maydanoz'),
          IngredientItem(turkishName: 'fesleğen'),
          IngredientItem(turkishName: 'dereotu'),
          IngredientItem(turkishName: 'çörek otu'),
          IngredientItem(turkishName: 'susam'),
          IngredientItem(turkishName: 'bal'),
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

