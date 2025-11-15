import 'package:dartz/dartz.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/recipe_local_data_source.dart';
import '../models/recipe_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeLocalDataSource localDataSource;
  
  final Map<RecipeCategory, List<String>> _shownRecipeIds = {};

  RecipeRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Recipe>> getRandomRecipe(RecipeCategory? category) async {
    try {
      if (category == null) {
        return const Left(ValidationFailure('Kategori seçmelisiniz'));
      }

      await Future.delayed(Duration(
        milliseconds: AppConstants.recipeFetchBaseDelayMs +
            (DateTime.now().millisecond % AppConstants.recipeFetchRandomDelayMs),
      ));

      final shownIds = _shownRecipeIds[category] ?? [];
      final recipe = localDataSource.getRandomRecipeByCategory(category, shownIds);
      
      if (!_shownRecipeIds.containsKey(category)) {
        _shownRecipeIds[category] = [];
      }
      _shownRecipeIds[category]!.add(recipe.id);
      
      if (_shownRecipeIds[category]!.length > AppConstants.maxShownRecipesPerCategory) {
        _shownRecipeIds[category]!.removeAt(0);
      }

      return Right(recipe);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure('Rastgele tarif alınırken hata oluştu: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Recipe>> getRecipeByName(String name) async {
    try {
      final allRecipes = localDataSource.getAllRecipes();
      final recipe = allRecipes.firstWhere(
        (r) => r.name.toLowerCase().contains(name.toLowerCase()),
        orElse: () => allRecipes.first,
      );
      return Right(recipe);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return const Left(NotFoundFailure('Tarif bulunamadı'));
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getRecipesByIngredients(
    List<String> ingredients,
    RecipeCategory? category,
  ) async {
    try {
      if (ingredients.isEmpty) {
        return const Left(ValidationFailure('En az bir malzeme seçmelisiniz'));
      }

      await Future.delayed(Duration(
        milliseconds: AppConstants.recipeFetchBaseDelayMs +
            (DateTime.now().millisecond % AppConstants.recipeFetchRandomDelayMs),
      ));

      List<RecipeModel> recipes;
      if (category != null) {
        recipes = localDataSource.getRecipesByCategory(category);
      } else {
        recipes = localDataSource.getAllRecipes();
      }

      final normalizedSelectedIngredients = ingredients
          .map((ing) => ing.toLowerCase().trim())
          .toList();

      final filteredRecipes = recipes.where((recipe) {
        final recipeIngredientsText = recipe.ingredients
            .map((ing) => ing.toLowerCase().trim())
            .join(' ');
        
        return normalizedSelectedIngredients.every((selectedIng) {
          return recipeIngredientsText.contains(selectedIng);
        });
      }).toList();
      
      if (filteredRecipes.isEmpty) {
        return const Left(NotFoundFailure('Seçilen malzemelerle tarif bulunamadı'));
      }

      return Right(filteredRecipes);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure('Malzemelere göre tarif aranırken hata oluştu: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllRecipeNames() async {
    try {
      final recipes = localDataSource.getAllRecipes();
      return Right(recipes.map((r) => r.name).toList());
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return const Left(ServerFailure('Tarif isimleri alınırken hata oluştu'));
    }
  }
}

