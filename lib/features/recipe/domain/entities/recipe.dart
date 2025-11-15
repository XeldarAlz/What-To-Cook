import 'package:equatable/equatable.dart';

enum RecipeCategory {
  kahvalti,
  ogleYemegi,
  aksamYemegi,
  tatli,
}

class Recipe extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> instructions;
  final RecipeCategory category;
  final int? prepTime;
  final int? cookTime;
  final int? servings;

  const Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
    required this.category,
    this.prepTime,
    this.cookTime,
    this.servings,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        ingredients,
        instructions,
        category,
        prepTime,
        cookTime,
        servings,
      ];
}

