class AppConstants {
  AppConstants._();

  static const Duration recipeDetailAnimationDuration = Duration(milliseconds: 800);
  static const Duration stateTransitionDuration = Duration(milliseconds: 300);
  static const Duration scrollAnimationDuration = Duration(milliseconds: 300);
  static const Duration loadingRotationDuration = Duration(milliseconds: 2000);
  static const Duration loadingPulseDuration = Duration(milliseconds: 1500);
  static const Duration loadingShimmerDuration = Duration(milliseconds: 1800);
  static const int recipeFetchBaseDelayMs = 1000;
  static const int recipeFetchRandomDelayMs = 1000;
  static const Duration resetAfterScrollDelay = Duration(milliseconds: 150);
  static const Duration loadRecipeAfterScrollDelay = Duration(milliseconds: 100);
  static const double ingredientsAnimationStart = 0.45;
  static const double ingredientsAnimationSpace = 0.2;
  static const double instructionsAnimationStart = 0.65;
  static const double instructionsAnimationSpace = 0.2;
  static const double itemAnimationDuration = 0.1;
  static const double itemAnimationMinSpacing = 0.05;
  static const double animationMaxStart = 0.9;
  static const int maxShownRecipesPerCategory = 15;
  static const double smallScreenWidthThreshold = 400.0;
  static const double progressIndicatorWidth = 250.0;
  static const double progressIndicatorHeight = 6.0;
  static const double progressIndicatorBorderRadius = 8.0;
  static const double dotAnimationDelayMultiplier = 0.2;
  static const double dotSize = 8.0;
  static const double dotMargin = 4.0;
  static const double shimmerGradientSpread = 0.3;
  static const double iconContainerPadding = 32.0;
  static const double iconSize = 80.0;
  static const double pulseMinScale = 0.9;
  static const double pulseMaxScale = 1.1;
  static const double rotationMultiplier = 0.1;
  static const double shadowBlurRadius = 20.0;
  static const double shadowSpreadRadius = 5.0;
  static const double primaryContainerAlpha = 0.2;
  static const double shadowAlpha = 0.2;
  static const double shimmerTextAlpha = 0.5;
  static const double dotAlphaMin = 0.3;
  static const double dotAlphaMax = 0.7;
  
  static const String recipesJsonUrl = 'https://raw.githubusercontent.com/XeldarAlz/What-To-Cook/main/data/recipes.json';
  static const String recipesCacheKey = 'recipes_cache';
  static const String recipesCacheTimestampKey = 'recipes_cache_timestamp';
  static const Duration recipesCacheDuration = Duration(hours: 24);
}
