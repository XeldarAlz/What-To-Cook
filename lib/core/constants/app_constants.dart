/// Global application constants
/// 
/// This file contains all global constants used throughout the app.
/// Modify values here to change behavior app-wide.
class AppConstants {
  AppConstants._(); // Private constructor to prevent instantiation

  // ============================================================================
  // Animation Durations
  // ============================================================================
  
  /// Duration for recipe detail widget fade animations
  static const Duration recipeDetailAnimationDuration = Duration(milliseconds: 800);
  
  /// Duration for state transition animations (AnimatedSwitcher)
  static const Duration stateTransitionDuration = Duration(milliseconds: 300);
  
  /// Duration for scroll animations
  static const Duration scrollAnimationDuration = Duration(milliseconds: 300);
  
  /// Duration for loading animation rotation
  static const Duration loadingRotationDuration = Duration(milliseconds: 2000);
  
  /// Duration for loading animation pulse
  static const Duration loadingPulseDuration = Duration(milliseconds: 1500);
  
  /// Duration for loading animation shimmer
  static const Duration loadingShimmerDuration = Duration(milliseconds: 1800);

  // ============================================================================
  // Delays
  // ============================================================================
  
  /// Base delay for recipe fetching (for UX)
  static const int recipeFetchBaseDelayMs = 1000;
  
  /// Random delay range for recipe fetching (adds randomness to base delay)
  static const int recipeFetchRandomDelayMs = 1000;
  
  /// Delay before resetting state after scroll animation
  static const Duration resetAfterScrollDelay = Duration(milliseconds: 150);
  
  /// Delay before loading new recipe after scroll
  static const Duration loadRecipeAfterScrollDelay = Duration(milliseconds: 100);

  // ============================================================================
  // Animation Intervals
  // ============================================================================
  
  /// Start position for ingredients list animation
  static const double ingredientsAnimationStart = 0.45;
  
  /// Available space for ingredients list animation
  static const double ingredientsAnimationSpace = 0.2;
  
  /// Start position for instructions list animation
  static const double instructionsAnimationStart = 0.65;
  
  /// Available space for instructions list animation
  static const double instructionsAnimationSpace = 0.2;
  
  /// Duration for each item animation
  static const double itemAnimationDuration = 0.1;
  
  /// Minimum spacing between item animations
  static const double itemAnimationMinSpacing = 0.05;
  
  /// Maximum start position for animations (to prevent overflow)
  static const double animationMaxStart = 0.9;

  // ============================================================================
  // Recipe Management
  // ============================================================================
  
  /// Maximum number of shown recipes to track per category
  static const int maxShownRecipesPerCategory = 15;

  // ============================================================================
  // UI Constants
  // ============================================================================
  
  /// Small screen width threshold (for responsive design)
  static const double smallScreenWidthThreshold = 400.0;
  
  /// Progress indicator width
  static const double progressIndicatorWidth = 250.0;
  
  /// Progress indicator height
  static const double progressIndicatorHeight = 6.0;
  
  /// Progress indicator border radius
  static const double progressIndicatorBorderRadius = 8.0;
  
  /// Dot animation delay multiplier
  static const double dotAnimationDelayMultiplier = 0.2;
  
  /// Dot size
  static const double dotSize = 8.0;
  
  /// Dot margin
  static const double dotMargin = 4.0;
  
  /// Shimmer gradient spread
  static const double shimmerGradientSpread = 0.3;
  
  /// Icon container padding
  static const double iconContainerPadding = 32.0;
  
  /// Icon size
  static const double iconSize = 80.0;
  
  /// Pulse animation min scale
  static const double pulseMinScale = 0.9;
  
  /// Pulse animation max scale
  static const double pulseMaxScale = 1.1;
  
  /// Rotation animation multiplier (for subtle rotation)
  static const double rotationMultiplier = 0.1;
  
  /// Shadow blur radius
  static const double shadowBlurRadius = 20.0;
  
  /// Shadow spread radius
  static const double shadowSpreadRadius = 5.0;
  
  /// Container alpha for primary container
  static const double primaryContainerAlpha = 0.2;
  
  /// Shadow alpha
  static const double shadowAlpha = 0.2;
  
  /// Text alpha for shimmer effect
  static const double shimmerTextAlpha = 0.5;
  
  /// Dot alpha range
  static const double dotAlphaMin = 0.3;
  static const double dotAlphaMax = 0.7;
}

