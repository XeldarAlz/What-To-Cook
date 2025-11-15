import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/utils/category_utils.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/recipe.dart';
import '../bloc/recipe_bloc.dart';
import '../bloc/recipe_state.dart';
import '../bloc/recipe_event.dart';
import '../widgets/recipe_detail_widget.dart';
import '../widgets/loading_animation_widget.dart';

class RandomRecipePage extends StatefulWidget {
  const RandomRecipePage({super.key});

  @override
  State<RandomRecipePage> createState() => _RandomRecipePageState();
}

class _RandomRecipePageState extends State<RandomRecipePage> {
  RecipeCategory? _selectedCategory;
  final ScrollController _scrollController = ScrollController();
  bool _isGoingBack = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RecipeBloc>(),
      child: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: state.maybeWhen(
              loaded: (_) => AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    final bloc = context.read<RecipeBloc>();
                    // Set flag to indicate we're going back
                    setState(() {
                      _isGoingBack = true;
                    });
                    // Scroll to top first for smooth transition
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        0,
                        duration: AppConstants.scrollAnimationDuration,
                        curve: Curves.easeInOut,
                      );
                    }
                    // Then reset after a short delay for smooth animation
                    Future.delayed(AppConstants.resetAfterScrollDelay, () {
                      if (mounted) {
                        bloc.add(
                          const RecipeEvent.reset(),
                        );
                      }
                    });
                  },
                  tooltip: 'Geri',
                ),
                title: const Text('Tarif'),
                elevation: 0,
              ),
              orElse: () => AppBar(
                title: const Text('Bugün Ne Pişirsek?'),
                elevation: 0,
                centerTitle: true,
              ),
            ),
            body: SafeArea(
              child: BlocListener<RecipeBloc, RecipeState>(
                listener: (context, state) {
                  // When a new recipe is loaded, scroll to top smoothly
                  state.maybeWhen(
                    loaded: (_) {
                      if (_scrollController.hasClients) {
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    orElse: () {},
                  );
                },
                child: AnimatedSwitcher(
                  duration: AppConstants.stateTransitionDuration,
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: _isGoingBack 
                              ? const Offset(1.0, 0.0) // Slide from right when going back
                              : const Offset(0.0, 0.05), // Slide from bottom when going forward
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                        child: child,
                      ),
                    );
                  },
                  child: state.maybeWhen(
                    initial: () {
                      // Reset flag when we reach initial state
                      if (_isGoingBack) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() {
                              _isGoingBack = false;
                            });
                          }
                        });
                      }
                      return _buildInitialView(context);
                    },
                    loading: () {
                      // Reset flag when loading starts (going forward)
                      if (_isGoingBack) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() {
                              _isGoingBack = false;
                            });
                          }
                        });
                      }
                      return const LoadingAnimationWidget(key: ValueKey('loading'));
                    },
                    loaded: (recipe) => RecipeDetailWidget(
                      key: ValueKey(recipe.id),
                      recipe: recipe,
                      scrollController: _scrollController,
                      onRefresh: () {
                        if (_selectedCategory != null) {
                          final bloc = context.read<RecipeBloc>();
                          // Scroll to top smoothly before loading new recipe
                          _scrollController.animateTo(
                            0,
                            duration: AppConstants.scrollAnimationDuration,
                            curve: Curves.easeInOut,
                          );
                          // Wait a bit for scroll animation, then load new recipe
                          Future.delayed(AppConstants.loadRecipeAfterScrollDelay, () {
                            if (mounted) {
                              bloc.add(
                                RecipeEvent.getRandomRecipe(_selectedCategory),
                              );
                            }
                          });
                        }
                      },
                    ),
                    error: (failure) => _buildErrorView(context, failure, key: ValueKey('error')),
                    orElse: () => _buildInitialView(context, key: const ValueKey('initial')),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInitialView(BuildContext context, {Key? key}) {
    return Center(
      key: key,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon with background
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.restaurant_menu,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),
              // Title
              Text(
                'Bugün Ne Pişirsek?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Kategori seçerek rastgele bir tarif alın',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
              ),
              const SizedBox(height: 48),
              // Category selection card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.category,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Kategori Seçin',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: RecipeCategory.values.map((category) {
                        final isSelected = _selectedCategory == category;
                        return FilterChip(
                          selected: isSelected,
                          label: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              CategoryUtils.getCategoryName(category),
                              style: TextStyle(
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = selected ? category : null;
                            });
                          },
                          selectedColor: Theme.of(context).colorScheme.primaryContainer,
                          checkmarkColor: Theme.of(context).colorScheme.onPrimaryContainer,
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Action button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _selectedCategory == null
                      ? null
                      : () {
                          context.read<RecipeBloc>().add(
                            RecipeEvent.getRandomRecipe(_selectedCategory),
                          );
                        },
                  icon: const Icon(Icons.search, size: 24),
                  label: const Text(
                    'Ne Pişirsem?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, Failure failure, {Key? key}) {
    return Center(
      key: key,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 24),
            Text(
              'Bir hata oluştu',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              failure.message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_selectedCategory != null) {
                  context.read<RecipeBloc>().add(
                    RecipeEvent.getRandomRecipe(_selectedCategory),
                  );
                }
              },
              child: const Text('Tekrar Dene'),
            ),
          ],
        ),
      ),
    );
  }
}

