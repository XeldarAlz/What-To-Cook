import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../../recipe/domain/usecases/get_recipes_by_ingredients.dart';
import 'ingredients_event.dart';
import 'ingredients_state.dart';
import 'dart:math';

class IngredientsBloc extends Bloc<IngredientsEvent, IngredientsState> {
  final GetRecipesByIngredients getRecipesByIngredients;
  final Random _random = Random();

  // Available ingredients list
  static const List<String> _availableIngredients = [
    'patlıcan',
    'kıyma',
    'domates',
    'soğan',
    'sarımsak',
    'biber',
    'zeytinyağı',
    'kabak',
    'yumurta',
    'un',
    'peynir',
    'makarna',
    'yufka',
    'karnabahar',
    'pırasa',
    'yoğurt',
    'tereyağı',
    'maydanoz',
    'fesleğen',
    'ekmek içi',
  ];

  IngredientsBloc({
    required this.getRecipesByIngredients,
  }) : super(const IngredientsState.initial(
          availableIngredients: _availableIngredients,
        )) {
    on<IngredientsEvent>((event, emit) {
      event.when(
        toggleIngredient: (ingredient) => _onToggleIngredient(ingredient, emit),
        getRecipeByIngredients: () => _onGetRecipeByIngredients(emit),
        clearSelection: () => _onClearSelection(emit),
      );
    });
  }

  void _onToggleIngredient(
    String ingredient,
    Emitter<IngredientsState> emit,
  ) {
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

    emit(currentState.maybeMap(
      initial: (s) => s.copyWith(selectedIngredients: newSelected),
      loading: (s) => s.copyWith(selectedIngredients: newSelected),
      loaded: (s) => s.copyWith(selectedIngredients: newSelected),
      error: (s) => s.copyWith(selectedIngredients: newSelected),
      orElse: () => IngredientsState.initial(
        selectedIngredients: newSelected,
        availableIngredients: availableIngredients,
      ),
    ));
  }

  Future<void> _onGetRecipeByIngredients(
    Emitter<IngredientsState> emit,
  ) async {
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
      emit(IngredientsState.error(
        failure: const ValidationFailure('Lütfen en az bir malzeme seçin'),
        selectedIngredients: selected,
        availableIngredients: availableIngredients,
      ));
      return;
    }

    emit(IngredientsState.loading(
      selectedIngredients: selected,
      availableIngredients: availableIngredients,
    ));

    final result = await getRecipesByIngredients(selected);
    result.fold(
      (failure) => emit(IngredientsState.error(
        failure: failure,
        selectedIngredients: selected,
        availableIngredients: availableIngredients,
      )),
      (recipes) {
        if (recipes.isEmpty) {
          emit(IngredientsState.error(
            failure: const NotFoundFailure('Seçilen malzemelerle tarif bulunamadı'),
            selectedIngredients: selected,
            availableIngredients: availableIngredients,
          ));
        } else {
          // Select random recipe from matching recipes
          final selectedRecipe = recipes[_random.nextInt(recipes.length)];
          emit(IngredientsState.loaded(
            recipe: selectedRecipe,
            selectedIngredients: selected,
            availableIngredients: availableIngredients,
          ));
        }
      },
    );
  }

  void _onClearSelection(
    Emitter<IngredientsState> emit,
  ) {
    emit(const IngredientsState.initial(
      availableIngredients: _availableIngredients,
    ));
  }
}

