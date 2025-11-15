import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../../recipe/domain/entities/recipe.dart';

part 'ingredients_state.freezed.dart';

@freezed
class IngredientsState with _$IngredientsState {
  const factory IngredientsState.initial({
    @Default(<String>[]) List<String> selectedIngredients,
    @Default(<String>[]) List<String> availableIngredients,
    RecipeCategory? selectedCategory,
  }) = _Initial;
  const factory IngredientsState.loading({
    required List<String> selectedIngredients,
    required List<String> availableIngredients,
    RecipeCategory? selectedCategory,
  }) = _Loading;
  const factory IngredientsState.loaded({
    required Recipe recipe,
    required List<String> selectedIngredients,
    required List<String> availableIngredients,
    RecipeCategory? selectedCategory,
  }) = _Loaded;
  const factory IngredientsState.error({
    required Failure failure,
    required List<String> selectedIngredients,
    required List<String> availableIngredients,
    RecipeCategory? selectedCategory,
  }) = _Error;
}

