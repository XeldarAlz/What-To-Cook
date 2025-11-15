import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/recipe.dart';

part 'recipe_state.freezed.dart';

@freezed
class RecipeState with _$RecipeState {
  const factory RecipeState.initial() = _Initial;
  const factory RecipeState.loading() = _Loading;
  const factory RecipeState.loaded(Recipe recipe) = _Loaded;
  const factory RecipeState.error(Failure failure) = _Error;
}

