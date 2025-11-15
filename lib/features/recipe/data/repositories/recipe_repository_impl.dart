import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/recipe_remote_data_source.dart';
import '../models/recipe_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  
  // For smart randomization - track shown recipes
  final List<String> _shownRecipeIds = [];

  RecipeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Recipe>> getRandomRecipe() async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure('Internet bağlantısı gerekli'));
      }

      // Check if we've shown this recipe before (simple check with URL)
      // Since we can't track all recipes from web, we'll just fetch a new one each time
      // but try to avoid immediate duplicates
      RecipeModel recipe;
      int attempts = 0;
      do {
        recipe = await remoteDataSource.getRandomRecipeFromWebsite();
        attempts++;
        // If we've seen this recipe recently and haven't tried too many times, try again
        if (_shownRecipeIds.contains(recipe.id) && attempts < 3) {
          await Future.delayed(const Duration(milliseconds: 500));
          continue;
        }
        break;
      } while (attempts < 3);

      // Track shown recipe (keep last 10 to avoid immediate repeats)
      _shownRecipeIds.add(recipe.id);
      if (_shownRecipeIds.length > 10) {
        _shownRecipeIds.removeAt(0);
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
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure('Internet bağlantısı gerekli'));
      }

      final remoteRecipe = await remoteDataSource.getRecipeFromWebsite(name);
      return Right(remoteRecipe);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure('Tarif alınırken hata oluştu: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getRecipesByIngredients(List<String> ingredients) async {
    try {
      if (ingredients.isEmpty) {
        return const Left(ValidationFailure('En az bir malzeme seçmelisiniz'));
      }

      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure('Internet bağlantısı gerekli'));
      }

      final recipes = await remoteDataSource.getRecipesByIngredientsFromWebsite(ingredients);
      
      if (recipes.isEmpty) {
        return const Left(NotFoundFailure('Seçilen malzemelerle tarif bulunamadı'));
      }

      return Right(recipes);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure('Malzemelere göre tarif aranırken hata oluştu: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllRecipeNames() async {
    // This method is not used in the current implementation
    // Return empty list since we don't have a local cache
    return const Right([]);
  }
}

