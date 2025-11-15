import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/recipe.dart';

class RecipeDetailWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Recipe Image
          SizedBox(
            height: isSmallScreen ? 250 : 300,
            child: CachedNetworkImage(
              imageUrl: recipe.imageUrl,
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
          
          // Recipe Name - Prominent and Large
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Text(
              recipe.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 28 : 36,
                    color: Theme.of(context).colorScheme.onSurface,
                    letterSpacing: 0.5,
                    height: 1.2,
                  ),
            ),
          ),

          // Recipe Info (Time, Servings)
          if (recipe.prepTime != null || recipe.cookTime != null || recipe.servings != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12.0 : 16.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (recipe.prepTime != null)
                    _buildInfoChip(
                      context,
                      Icons.timer_outlined,
                      '${recipe.prepTime} dk',
                    ),
                  if (recipe.cookTime != null)
                    _buildInfoChip(
                      context,
                      Icons.restaurant,
                      '${recipe.cookTime} dk',
                    ),
                  if (recipe.servings != null)
                    _buildInfoChip(
                      context,
                      Icons.people_outline,
                      '${recipe.servings} kişi',
                    ),
                ],
              ),
            ),

          SizedBox(height: isSmallScreen ? 12 : 16),

          // Ingredients Section
          Padding(
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
                ...recipe.ingredients.map((ingredient) {
                  return Padding(
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
                            ingredient,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontSize: isSmallScreen ? 14 : null,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: isSmallScreen ? 20 : 24),

          // Instructions Section
          Padding(
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
                ...recipe.instructions.asMap().entries.map((entry) {
                  final index = entry.key + 1;
                  final instruction = entry.value;
                  return Padding(
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
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: isSmallScreen ? 24 : 32),

          // Try Another Button
          if (onRefresh != null)
            Padding(
              padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
              child: ElevatedButton.icon(
                onPressed: onRefresh,
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

