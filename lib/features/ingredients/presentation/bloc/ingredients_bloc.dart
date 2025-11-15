import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../../recipe/domain/usecases/get_recipes_by_ingredients.dart';
import '../../data/datasources/ingredients_data_source.dart';
import 'ingredients_event.dart';
import 'ingredients_state.dart';
import 'dart:math';

class IngredientsBloc extends Bloc<IngredientsEvent, IngredientsState> {
  final GetRecipesByIngredients getRecipesByIngredients;
  final Random _random = Random();

  // Available ingredients list
  static final List<String> _availableIngredients = 
      IngredientsDataSource.getAllTurkishNames();

  IngredientsBloc({required this.getRecipesByIngredients})
    : super(
        IngredientsState.initial(
          availableIngredients: _availableIngredients,
        ),
      ) {
    on<IngredientsEvent>((event, emit) async {
      await event.map(
        toggleIngredient: (e) async => _onToggleIngredient(e.ingredient, emit),
        getRecipeByIngredients: (_) async =>
            await _onGetRecipeByIngredients(emit),
        clearSelection: (_) async => _onClearSelection(emit),
      );
    });
  }

  void _onToggleIngredient(String ingredient, Emitter<IngredientsState> emit) {
    final currentState = state;
    final currentSelected = currentState.maybeMap(
      initial: (s) => s.selectedIngredients,
      loading: (s) => s.selectedIngredients,
      loaded: (s) => s.selectedIngredients,
      error: (s) => s.selectedIngredients,
      orElse: () => <String>[],
    );
    final availableIngredients = currentState.maybeMap(
      initial: (s) => s.availableIngredients,
      loading: (s) => s.availableIngredients,
      loaded: (s) => s.availableIngredients,
      error: (s) => s.availableIngredients,
      orElse: () => _availableIngredients,
    );

    List<String> newSelected;
    if (currentSelected.contains(ingredient)) {
      newSelected = List.from(currentSelected)..remove(ingredient);
    } else {
      newSelected = List.from(currentSelected)..add(ingredient);
    }

    emit(
      currentState.maybeMap(
        initial: (s) => s.copyWith(selectedIngredients: newSelected),
        loading: (s) => s.copyWith(selectedIngredients: newSelected),
        loaded: (s) => s.copyWith(selectedIngredients: newSelected),
        error: (s) => s.copyWith(selectedIngredients: newSelected),
        orElse: () => IngredientsState.initial(
          selectedIngredients: newSelected,
          availableIngredients: availableIngredients,
        ),
      ),
    );
  }

  Future<void> _onGetRecipeByIngredients(Emitter<IngredientsState> emit) async {
    final currentState = state;
    final selected = currentState.maybeMap(
      initial: (s) => s.selectedIngredients,
      loading: (s) => s.selectedIngredients,
      loaded: (s) => s.selectedIngredients,
      error: (s) => s.selectedIngredients,
      orElse: () => <String>[],
    );
    final availableIngredients = currentState.maybeMap(
      initial: (s) => s.availableIngredients,
      loading: (s) => s.availableIngredients,
      loaded: (s) => s.availableIngredients,
      error: (s) => s.availableIngredients,
      orElse: () => _availableIngredients,
    );

    if (selected.isEmpty) {
      emit(
        IngredientsState.error(
          failure: const ValidationFailure('Lütfen en az bir malzeme seçin'),
          selectedIngredients: selected,
          availableIngredients: availableIngredients,
        ),
      );
      return;
    }

    emit(
      IngredientsState.loading(
        selectedIngredients: selected,
        availableIngredients: availableIngredients,
      ),
    );

    // Convert Turkish ingredient names to English for TheMealDB API
    final englishIngredients = IngredientsDataSource.getEnglishNames(selected);
    
    if (englishIngredients.isEmpty) {
      emit(
        IngredientsState.error(
          failure: const ValidationFailure(
            'Seçilen malzemeler API\'de bulunamadı. Lütfen farklı malzemeler seçin.',
          ),
          selectedIngredients: selected,
          availableIngredients: availableIngredients,
        ),
      );
      return;
    }

    final result = await getRecipesByIngredients(englishIngredients);
    result.fold(
      (failure) => emit(
        IngredientsState.error(
          failure: failure,
          selectedIngredients: selected,
          availableIngredients: availableIngredients,
        ),
      ),
      (recipes) {
        if (recipes.isEmpty) {
          emit(
            IngredientsState.error(
              failure: const NotFoundFailure(
                'Seçilen malzemelerle tarif bulunamadı',
              ),
              selectedIngredients: selected,
              availableIngredients: availableIngredients,
            ),
          );
        } else {
          // Select random recipe from matching recipes
          final selectedRecipe = recipes[_random.nextInt(recipes.length)];
          emit(
            IngredientsState.loaded(
              recipe: selectedRecipe,
              selectedIngredients: selected,
              availableIngredients: availableIngredients,
            ),
          );
        }
      },
    );
  }

  void _onClearSelection(Emitter<IngredientsState> emit) {
    emit(
      IngredientsState.initial(
        availableIngredients: _availableIngredients,
      ),
    );
  }
}
