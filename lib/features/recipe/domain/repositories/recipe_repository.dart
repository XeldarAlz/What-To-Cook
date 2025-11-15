import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, Recipe>> getRandomRecipe(RecipeCategory? category);
  Future<Either<Failure, Recipe>> getRecipeByName(String name);
  Future<Either<Failure, List<Recipe>>> getRecipesByIngredients(List<String> ingredients, RecipeCategory? category);
  Future<Either<Failure, List<String>>> getAllRecipeNames();
}

