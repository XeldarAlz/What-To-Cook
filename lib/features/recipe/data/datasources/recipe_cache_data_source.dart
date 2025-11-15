import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../models/recipe_model.dart';

abstract class RecipeCacheDataSource {
  Future<void> cacheRecipes(List<RecipeModel> recipes);
  Future<List<RecipeModel>?> getCachedRecipes();
  Future<bool> isCacheValid();
  Future<void> clearCache();
}

class RecipeCacheDataSourceImpl implements RecipeCacheDataSource {
  final SharedPreferences sharedPreferences;

  RecipeCacheDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheRecipes(List<RecipeModel> recipes) async {
    try {
      final jsonList = recipes.map((recipe) => recipe.toJson()).toList();
      final jsonString = json.encode(jsonList);
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      await sharedPreferences.setString(
        AppConstants.recipesCacheKey,
        jsonString,
      );
      await sharedPreferences.setInt(
        AppConstants.recipesCacheTimestampKey,
        timestamp,
      );
    } catch (e) {
      throw CacheFailure('Error caching recipes: ${e.toString()}');
    }
  }

  @override
  Future<List<RecipeModel>?> getCachedRecipes() async {
    try {
      final jsonString = sharedPreferences.getString(AppConstants.recipesCacheKey);
      if (jsonString == null) {
        return null;
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList
          .map((json) => RecipeModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw CacheFailure('Error reading cached recipes: ${e.toString()}');
    }
  }

  @override
  Future<bool> isCacheValid() async {
    try {
      final timestamp = sharedPreferences.getInt(AppConstants.recipesCacheTimestampKey);
      if (timestamp == null) {
        return false;
      }

      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final difference = now.difference(cacheTime);

      return difference < AppConstants.recipesCacheDuration;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await sharedPreferences.remove(AppConstants.recipesCacheKey);
      await sharedPreferences.remove(AppConstants.recipesCacheTimestampKey);
    } catch (e) {
      throw CacheFailure('Error clearing cache: ${e.toString()}');
    }
  }
}

