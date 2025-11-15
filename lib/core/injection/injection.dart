import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../features/recipe/data/datasources/recipe_remote_data_source.dart';
import '../../features/recipe/data/repositories/recipe_repository_impl.dart';
import '../../features/recipe/domain/repositories/recipe_repository.dart';
import '../../features/recipe/domain/usecases/get_random_recipe.dart';
import '../../features/recipe/domain/usecases/get_recipe_by_name.dart';
import '../../features/recipe/domain/usecases/get_recipes_by_ingredients.dart';
import '../../features/recipe/presentation/bloc/recipe_bloc.dart';
import '../../features/ingredients/presentation/bloc/ingredients_bloc.dart';
import '../network/network_info.dart';
import '../network/translator.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(Connectivity()),
  );

  // External
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => Connectivity());

  // Core - Translator
  getIt.registerLazySingleton<Translator>(
    () => Translator(client: getIt()),
  );

  // Features - Recipe
  // Data sources
  getIt.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImpl(
      client: getIt(),
      translator: getIt(),
    ),
  );

  // Repository
  getIt.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton<GetRandomRecipe>(() => GetRandomRecipe(getIt()));
  getIt.registerLazySingleton<GetRecipeByName>(() => GetRecipeByName(getIt()));
  getIt.registerLazySingleton<GetRecipesByIngredients>(() => GetRecipesByIngredients(getIt()));

  // Bloc
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

