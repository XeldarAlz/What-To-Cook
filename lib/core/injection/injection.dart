import 'package:get_it/get_it.dart';
import '../../features/recipe/data/datasources/recipe_local_data_source.dart';
import '../../features/recipe/data/repositories/recipe_repository_impl.dart';
import '../../features/recipe/domain/repositories/recipe_repository.dart';
import '../../features/recipe/domain/usecases/get_random_recipe.dart';
import '../../features/recipe/domain/usecases/get_recipe_by_name.dart';
import '../../features/recipe/domain/usecases/get_recipes_by_ingredients.dart';
import '../../features/recipe/presentation/bloc/recipe_bloc.dart';
import '../../features/ingredients/presentation/bloc/ingredients_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  getIt.registerLazySingleton<RecipeLocalDataSource>(
    () => RecipeLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(
      localDataSource: getIt(),
    ),
  );

  getIt.registerLazySingleton<GetRandomRecipe>(() => GetRandomRecipe(getIt()));
  getIt.registerLazySingleton<GetRecipeByName>(() => GetRecipeByName(getIt()));
  getIt.registerLazySingleton<GetRecipesByIngredients>(() => GetRecipesByIngredients(getIt()));

  getIt.registerFactory(
    () => RecipeBloc(
      getRandomRecipe: getIt(),
      getRecipeByName: getIt(),
    ),
  );
  getIt.registerFactory(
    () => IngredientsBloc(
      getRecipesByIngredients: getIt(),
    ),
  );
}

