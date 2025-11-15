import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class GetRandomRecipe {
  final RecipeRepository repository;

  GetRandomRecipe(this.repository);

  Future<Either<Failure, Recipe>> call(RecipeCategory? category) async {
    return await repository.getRandomRecipe(category);
  }
}

