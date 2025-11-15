import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/recipe.dart';

part 'recipe_event.freezed.dart';

@freezed
class RecipeEvent with _$RecipeEvent {
  const factory RecipeEvent.getRandomRecipe(RecipeCategory? category) = _GetRandomRecipe;
  const factory RecipeEvent.getRecipeByName(String name) = _GetRecipeByName;
}

