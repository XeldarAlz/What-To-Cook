import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> instructions;
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
        prepTime,
        cookTime,
        servings,
      ];
}

