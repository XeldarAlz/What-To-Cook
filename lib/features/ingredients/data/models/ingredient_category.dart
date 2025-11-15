class IngredientCategory {
  final String name;
  final String icon;
  final List<IngredientItem> items;

  const IngredientCategory({
    required this.name,
    required this.icon,
    required this.items,
  });
}

class IngredientItem {
  final String turkishName;

  const IngredientItem({
    required this.turkishName,
  });
}

