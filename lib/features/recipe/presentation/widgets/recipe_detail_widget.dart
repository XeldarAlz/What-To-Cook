import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/recipe.dart';

class RecipeDetailWidget extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback? onRefresh;
  final ScrollController? scrollController;

  const RecipeDetailWidget({
    super.key,
    required this.recipe,
    this.onRefresh,
    this.scrollController,
  });

  @override
  State<RecipeDetailWidget> createState() => _RecipeDetailWidgetState();
}

class _RecipeDetailWidgetState extends State<RecipeDetailWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppConstants.recipeDetailAnimationDuration,
      vsync: this,
    );

    // Create staggered fade animations for each section
    _fadeAnimations = List.generate(
      6, // Image, Name, Info, Ingredients title, Ingredients list, Instructions title, Instructions list
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.15,
            (index * 0.15) + 0.3,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  void didUpdateWidget(RecipeDetailWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.recipe.id != widget.recipe.id) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Recipe Image with fade animation
          FadeTransition(
            opacity: _fadeAnimations[0],
            child: SizedBox(
              height: isSmallScreen ? 250 : 300,
              child: CachedNetworkImage(
                imageUrl: widget.recipe.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.restaurant_menu, size: 80),
                ),
              ),
            ),
          ),
          
          // Recipe Name with fade animation
          FadeTransition(
            opacity: _fadeAnimations[1],
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
              child: Text(
                widget.recipe.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 22 : null,
                    ),
              ),
            ),
          ),

          // Recipe Info (Time, Servings) with fade animation
          if (widget.recipe.prepTime != null || widget.recipe.cookTime != null || widget.recipe.servings != null)
            FadeTransition(
              opacity: _fadeAnimations[2],
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12.0 : 16.0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (widget.recipe.prepTime != null)
                      _buildInfoChip(
                        context,
                        Icons.timer_outlined,
                        '${widget.recipe.prepTime} dk',
                      ),
                    if (widget.recipe.cookTime != null)
                      _buildInfoChip(
                        context,
                        Icons.restaurant,
                        '${widget.recipe.cookTime} dk',
                      ),
                    if (widget.recipe.servings != null)
                      _buildInfoChip(
                        context,
                        Icons.people_outline,
                        '${widget.recipe.servings} kişi',
                      ),
                  ],
                ),
              ),
            ),

          SizedBox(height: isSmallScreen ? 12 : 16),

          // Ingredients Section with fade animation
          FadeTransition(
            opacity: _fadeAnimations[3],
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Malzemeler',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 20 : null,
                        ),
                  ),
                  const SizedBox(height: 12),
                  ...widget.recipe.ingredients.asMap().entries.map((entry) {
                    final index = entry.key;
                    final totalItems = widget.recipe.ingredients.length;
                    // Calculate interval spacing based on available space
                    final availableSpace = AppConstants.ingredientsAnimationSpace;
                    final itemSpacing = totalItems > 1 
                        ? availableSpace / totalItems 
                        : 0.0;
                    // Calculate start position - limit to maxStart to ensure end <= 1.0
                    final rawStart = AppConstants.ingredientsAnimationStart + (index * itemSpacing);
                    final start = rawStart.clamp(0.0, AppConstants.animationMaxStart);
                    // Calculate end position - ensure it's always > start and <= 1.0
                    final end = (start + AppConstants.itemAnimationDuration)
                        .clamp(start + AppConstants.itemAnimationMinSpacing, 1.0);
                    
                    // Final validation - ensure start < end and end <= 1.0
                    if (start >= end || end > 1.0 || start < 0.0) {
                      // Fallback: use section animation if individual calculation fails
                      return FadeTransition(
                        opacity: _fadeAnimations[3],
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                size: isSmallScreen ? 18 : 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  entry.value,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontSize: isSmallScreen ? 14 : null,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    
                    return FadeTransition(
                      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Interval(
                            start,
                            end,
                            curve: Curves.easeOut,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: isSmallScreen ? 18 : 20,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                entry.value,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: isSmallScreen ? 14 : null,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          SizedBox(height: isSmallScreen ? 20 : 24),

          // Instructions Section with fade animation
          FadeTransition(
            opacity: _fadeAnimations[4],
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yapılışı',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 20 : null,
                        ),
                  ),
                  const SizedBox(height: 12),
                  ...widget.recipe.instructions.asMap().entries.map((entry) {
                    final index = entry.key + 1;
                    final instruction = entry.value;
                    final totalItems = widget.recipe.instructions.length;
                    // Calculate interval spacing based on available space
                    final availableSpace = AppConstants.instructionsAnimationSpace;
                    final itemSpacing = totalItems > 1 
                        ? availableSpace / totalItems 
                        : 0.0;
                    // Calculate start position - limit to maxStart to ensure end <= 1.0
                    final rawStart = AppConstants.instructionsAnimationStart + (entry.key * itemSpacing);
                    final start = rawStart.clamp(0.0, AppConstants.animationMaxStart);
                    // Calculate end position - ensure it's always > start and <= 1.0
                    final end = (start + AppConstants.itemAnimationDuration)
                        .clamp(start + AppConstants.itemAnimationMinSpacing, 1.0);
                    
                    // Final validation - ensure start < end and end <= 1.0
                    if (start >= end || end > 1.0 || start < 0.0) {
                      // Fallback: use section animation if individual calculation fails
                      return FadeTransition(
                        opacity: _fadeAnimations[4],
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: isSmallScreen ? 28 : 32,
                                height: isSmallScreen ? 28 : 32,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '$index',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: isSmallScreen ? 14 : null,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  instruction,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontSize: isSmallScreen ? 14 : null,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    
                    return FadeTransition(
                      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Interval(
                            start,
                            end,
                            curve: Curves.easeOut,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: isSmallScreen ? 28 : 32,
                              height: isSmallScreen ? 28 : 32,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '$index',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isSmallScreen ? 14 : null,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                instruction,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: isSmallScreen ? 14 : null,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          SizedBox(height: isSmallScreen ? 24 : 32),

          // Try Another Button with fade animation
          if (widget.onRefresh != null)
            FadeTransition(
              opacity: _fadeAnimations[5],
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
                child: ElevatedButton.icon(
                  onPressed: widget.onRefresh,
                  icon: const Icon(Icons.refresh),
                  label: Text(
                    'Başka Bir Tarif Dene',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: isSmallScreen ? 14 : 16,
                      horizontal: isSmallScreen ? 16 : 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String text) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(text),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
    );
  }
}

