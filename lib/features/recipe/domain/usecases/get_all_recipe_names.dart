import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/recipe_repository.dart';

class GetAllRecipeNames {
  final RecipeRepository repository;

  GetAllRecipeNames(this.repository);

  Future<Either<Failure, List<String>>> call() async {
    return await repository.getAllRecipeNames();
  }
}

