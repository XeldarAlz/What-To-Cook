import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_random_recipe.dart';
import '../../domain/usecases/get_recipe_by_name.dart';
import '../../domain/entities/recipe.dart';
import 'recipe_event.dart';
import 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetRandomRecipe getRandomRecipe;
  final GetRecipeByName getRecipeByName;

  RecipeBloc({
    required this.getRandomRecipe,
    required this.getRecipeByName,
  }) : super(const RecipeState.initial()) {
    on<RecipeEvent>((event, emit) async {
      await event.map(
        getRandomRecipe: (e) async => await _onGetRandomRecipe(e.category, emit),
        getRecipeByName: (e) async => await _onGetRecipeByName(e.name, emit),
      );
    });
  }

  Future<void> _onGetRandomRecipe(RecipeCategory? category, Emitter<RecipeState> emit) async {
    emit(const RecipeState.loading());
    final result = await getRandomRecipe(category);
    result.fold(
      (failure) => emit(RecipeState.error(failure)),
      (recipe) => emit(RecipeState.loaded(recipe)),
    );
  }

  Future<void> _onGetRecipeByName(String name, Emitter<RecipeState> emit) async {
    emit(const RecipeState.loading());
    final result = await getRecipeByName(name);
    result.fold(
      (failure) => emit(RecipeState.error(failure)),
      (recipe) => emit(RecipeState.loaded(recipe)),
    );
  }
}

