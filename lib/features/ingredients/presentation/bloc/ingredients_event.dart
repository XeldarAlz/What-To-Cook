import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../recipe/domain/entities/recipe.dart';

part 'ingredients_event.freezed.dart';

@freezed
class IngredientsEvent with _$IngredientsEvent {
  const factory IngredientsEvent.toggleIngredient(String ingredient) = _ToggleIngredient;
  const factory IngredientsEvent.selectCategory(RecipeCategory? category) = _SelectCategory;
  const factory IngredientsEvent.getRecipeByIngredients() = _GetRecipeByIngredients;
  const factory IngredientsEvent.clearSelection() = _ClearSelection;
}

