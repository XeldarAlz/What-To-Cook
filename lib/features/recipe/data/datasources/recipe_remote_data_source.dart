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
      final response = await client.get(
        Uri.parse(AppConstants.recipesJsonUrl),
      ).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => RecipeModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerFailure('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw ServerFailure('Error fetching recipes: ${e.toString()}');
    }
  }
}

