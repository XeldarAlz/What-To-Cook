import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class GetRecipeByName {
  final RecipeRepository repository;

  GetRecipeByName(this.repository);

  Future<Either<Failure, Recipe>> call(String name) async {
    return await repository.getRecipeByName(name);
  }
}

