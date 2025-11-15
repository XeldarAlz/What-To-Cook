import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_event.freezed.dart';

@freezed
class RecipeEvent with _$RecipeEvent {
  const factory RecipeEvent.getRandomRecipe() = _GetRandomRecipe;
  const factory RecipeEvent.getRecipeByName(String name) = _GetRecipeByName;
}

