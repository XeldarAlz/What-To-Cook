import 'package:dartz/dartz.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/recipe_local_data_source.dart';
import '../datasources/recipe_remote_data_source.dart';
import '../datasources/recipe_cache_data_source.dart';
import '../models/recipe_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeLocalDataSource localDataSource;
  final RecipeRemoteDataSource remoteDataSource;
  final RecipeCacheDataSource cacheDataSource;
  
  final Map<RecipeCategory, List<String>> _shownRecipeIds = {};
  List<RecipeModel>? _cachedRecipes;

  RecipeRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.cacheDataSource,
  });

  Future<List<RecipeModel>> _getAllRecipes() async {
    if (_cachedRecipes != null) {
      return _cachedRecipes!;
    }

    try {
      final isCacheValid = await cacheDataSource.isCacheValid();
      if (isCacheValid) {
        final cachedRecipes = await cacheDataSource.getCachedRecipes();
        if (cachedRecipes != null && cachedRecipes.isNotEmpty) {
          _cachedRecipes = cachedRecipes;
          return cachedRecipes;
        }
      }
    } catch (e) {
    }

    try {
      final remoteRecipes = await remoteDataSource.getRecipesFromRemote();
      if (remoteRecipes.isNotEmpty) {
        await cacheDataSource.cacheRecipes(remoteRecipes);
        _cachedRecipes = remoteRecipes;
        return remoteRecipes;
      }
    } catch (e) {
    }

    final localRecipes = localDataSource.getAllRecipes();
    _cachedRecipes = localRecipes;
    return localRecipes;
  }

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

      final allRecipes = await _getAllRecipes();
      final categoryRecipes = allRecipes.where((r) => r.category == category).toList();
      
      final shownIds = _shownRecipeIds[category] ?? [];
      final availableRecipes = categoryRecipes
          .where((recipe) => !shownIds.contains(recipe.id))
          .toList();
      
      RecipeModel recipe;
      if (availableRecipes.isEmpty) {
        recipe = categoryRecipes[DateTime.now().millisecond % categoryRecipes.length];
      } else {
        recipe = availableRecipes[DateTime.now().millisecond % availableRecipes.length];
      }
      
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
      final allRecipes = await _getAllRecipes();
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

      final allRecipes = await _getAllRecipes();
      List<RecipeModel> recipes;
      if (category != null) {
        recipes = allRecipes.where((r) => r.category == category).toList();
      } else {
        recipes = allRecipes;
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
      final recipes = await _getAllRecipes();
      return Right(recipes.map((r) => r.name).toList());
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return const Left(ServerFailure('Tarif isimleri alınırken hata oluştu'));
    }
  }
}

