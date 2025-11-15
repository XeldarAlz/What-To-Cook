import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
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

class _RecipeDetailWidgetState extends State<RecipeDetailWidget> {
  // Track completed steps
  final Set<int> _completedSteps = {};
  
  // Confetti controller
  late ConfettiController _confettiController;
  
  // Track if confetti has been shown for this recipe
  bool _confettiShown = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _toggleStep(int index) {
    setState(() {
      if (_completedSteps.contains(index)) {
        _completedSteps.remove(index);
      } else {
        _completedSteps.add(index);
      }
    });
    
    // Check if all steps are completed
    _checkAllStepsCompleted();
  }

  void _checkAllStepsCompleted() {
    final allStepsCompleted = _completedSteps.length == widget.recipe.instructions.length;
    
    if (allStepsCompleted && !_confettiShown) {
      // Trigger haptic feedback (light)
      HapticFeedback.lightImpact();
      
      // Show confetti animation
      _confettiController.play();
      
      // Mark confetti as shown for this recipe
      _confettiShown = true;
    }
  }

  @override
  void didUpdateWidget(RecipeDetailWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset confetti flag when recipe changes
    if (oldWidget.recipe.id != widget.recipe.id) {
      _confettiShown = false;
      _completedSteps.clear();
      _confettiController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    
    return Stack(
      children: [
        SingleChildScrollView(
      controller: widget.scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Recipe Image
          SizedBox(
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
              widget.recipe.name,
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

          // Recipe Info (Time, Servings) - Centered and Modern
          if (widget.recipe.prepTime != null || widget.recipe.cookTime != null || widget.recipe.servings != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12.0 : 16.0, vertical: isSmallScreen ? 12 : 16),
              child: Container(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.recipe.prepTime != null) ...[
                      _buildModernInfoChip(
                        context,
                        Icons.timer_outlined,
                        '${widget.recipe.prepTime}',
                        'dk',
                        isSmallScreen,
                      ),
                      if (widget.recipe.cookTime != null || widget.recipe.servings != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                            width: 1,
                            height: 30,
                            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                          ),
                        ),
                    ],
                    if (widget.recipe.cookTime != null) ...[
                      _buildModernInfoChip(
                        context,
                        Icons.restaurant,
                        '${widget.recipe.cookTime}',
                        'dk',
                        isSmallScreen,
                      ),
                      if (widget.recipe.servings != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                            width: 1,
                            height: 30,
                            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                          ),
                        ),
                    ],
                    if (widget.recipe.servings != null)
                      _buildModernInfoChip(
                        context,
                        Icons.people_outline,
                        '${widget.recipe.servings}',
                        'kişi',
                        isSmallScreen,
                      ),
                  ],
                ),
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
                ...widget.recipe.ingredients.map((ingredient) {
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
                ...widget.recipe.instructions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final instruction = entry.value;
                  final isCompleted = _completedSteps.contains(index);
                  return InkWell(
                    onTap: () => _toggleStep(index),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Checkbox/Step indicator
                          Container(
                            width: isSmallScreen ? 32 : 36,
                            height: isSmallScreen ? 32 : 36,
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.surfaceContainerHighest,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isCompleted
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: isCompleted
                                  ? Icon(
                                      Icons.check,
                                      color: Theme.of(context).colorScheme.onPrimary,
                                      size: isSmallScreen ? 18 : 20,
                                    )
                                  : Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSurface,
                                        fontWeight: FontWeight.bold,
                                        fontSize: isSmallScreen ? 14 : 16,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  instruction,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontSize: isSmallScreen ? 14 : null,
                                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                                        color: isCompleted
                                            ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)
                                            : Theme.of(context).colorScheme.onSurface,
                                      ),
                                ),
                                if (isCompleted) ...[
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        size: 14,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Tamamlandı',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Theme.of(context).colorScheme.primary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
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

          SizedBox(height: isSmallScreen ? 24 : 32),

          // Try Another Button
          if (widget.onRefresh != null)
            Padding(
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
        ],
      ),
    ),
        // Confetti widget - positioned at the top center
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: 1.5708, // 90 degrees (downward)
            maxBlastForce: 5,
            minBlastForce: 2,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            gravity: 0.1,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
              Colors.red,
              Colors.yellow,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModernInfoChip(
    BuildContext context,
    IconData icon,
    String value,
    String unit,
    bool isSmallScreen,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: isSmallScreen ? 20 : 24,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 18 : 22,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            Text(
              unit,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: isSmallScreen ? 11 : 12,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

