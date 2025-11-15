import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../models/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> getRecipesFromRemote();
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;

  RecipeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RecipeModel>> getRecipesFromRemote() async {
    try {
      final List<RecipeModel> allRecipes = [];
      
      for (final url in AppConstants.recipesJsonUrls) {
        try {
          final response = await client.get(
            Uri.parse(url),
          ).timeout(
            const Duration(seconds: 10),
          );

          if (response.statusCode == 200) {
            final List<dynamic> jsonList = json.decode(response.body);
            final recipes = jsonList
                .map((json) => RecipeModel.fromJson(json as Map<String, dynamic>))
                .toList();
            allRecipes.addAll(recipes);
          } else {
            throw ServerFailure('Failed to load recipes from $url: ${response.statusCode}');
          }
        } catch (e) {
          if (e is Failure) {
            rethrow;
          }
          throw ServerFailure('Error fetching recipes from $url: ${e.toString()}');
        }
      }
      
      return allRecipes;
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw ServerFailure('Error fetching recipes: ${e.toString()}');
    }
  }
}

