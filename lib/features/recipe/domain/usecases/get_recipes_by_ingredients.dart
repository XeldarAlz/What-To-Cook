import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class GetRecipesByIngredients {
  final RecipeRepository repository;

  GetRecipesByIngredients(this.repository);

  Future<Either<Failure, List<Recipe>>> call(List<String> ingredients) async {
    return await repository.getRecipesByIngredients(ingredients);
  }
}

