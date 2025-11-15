import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/utils/category_utils.dart';
import '../../../../core/error/failures.dart';
import '../bloc/ingredients_bloc.dart';
import '../bloc/ingredients_state.dart';
import '../bloc/ingredients_event.dart';
import '../../../recipe/presentation/widgets/recipe_detail_widget.dart';
import '../../../recipe/presentation/widgets/loading_animation_widget.dart';
import '../../../recipe/domain/entities/recipe.dart';
import '../../data/datasources/ingredients_data_source.dart';
import '../../data/models/ingredient_category.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<IngredientsBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<IngredientsBloc, IngredientsState>(
            builder: (context, state) {
              return state.maybeWhen(
                initial: (selected, available, category) => _buildIngredientsSelectionView(
                  context,
                  selected,
                  available,
                  selectedCategory: category,
                ),
                loading: (selected, available, category) => const LoadingAnimationWidget(),
                loaded: (recipe, selected, available, category) => _buildIngredientsSelectionView(
                  context,
                  selected,
                  available,
                  selectedCategory: category,
                  recipe: recipe,
                ),
                error: (failure, selected, available, category) => _buildIngredientsSelectionView(
                  context,
                  selected,
                  available,
                  selectedCategory: category,
                  error: failure,
                ),
                orElse: () => _buildIngredientsSelectionView(context, [], [], selectedCategory: null),
              );
            },
          ),
        ),
      ),
    );
  }


  Widget _buildIngredientsSelectionView(
    BuildContext context,
    List<String> selectedIngredients,
    List<String> availableIngredients, {
    Recipe? recipe,
    Failure? error,
    RecipeCategory? selectedCategory,
  }) {
    final categories = IngredientsDataSource.getCategories();

    return Column(
      children: [
        // Selected ingredients section
        if (selectedIngredients.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Seçilen Malzemeler (${selectedIngredients.length})',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        context.read<IngredientsBloc>().add(
                              const IngredientsEvent.clearSelection(),
                            );
                      },
                      icon: const Icon(Icons.clear, size: 18),
                      label: const Text('Temizle'),
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: selectedIngredients.map((ingredient) {
                    return Chip(
                      label: Text(ingredient),
                      avatar: const Icon(Icons.check, size: 18),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      deleteIcon: Icon(
                        Icons.close,
                        size: 18,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onDeleted: () {
                        context.read<IngredientsBloc>().add(
                              IngredientsEvent.toggleIngredient(ingredient),
                            );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

        // Content area (recipe, error, or ingredients list)
        Expanded(
          child: recipe != null
              ? RecipeDetailWidget(
                  recipe: recipe,
                  onRefresh: () {
                    context.read<IngredientsBloc>().add(
                          const IngredientsEvent.getRecipeByIngredients(),
                        );
                  },
                )
              : error != null
                  ? _buildErrorView(context, error)
                  : Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kategori Seçin',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  FilterChip(
                                    selected: selectedCategory == null,
                                    label: const Text('Tümü'),
                                    onSelected: (selected) {
                                      context.read<IngredientsBloc>().add(
                                        IngredientsEvent.selectCategory(null),
                                      );
                                    },
                                    selectedColor: Theme.of(context).colorScheme.primaryContainer,
                                    checkmarkColor: Theme.of(context).colorScheme.onPrimaryContainer,
                                  ),
                                  ...RecipeCategory.values.map((category) {
                                    final isSelected = selectedCategory == category;
                                    return FilterChip(
                                      selected: isSelected,
                                      label: Text(CategoryUtils.getCategoryName(category)),
                                      onSelected: (selected) {
                                        context.read<IngredientsBloc>().add(
                                          IngredientsEvent.selectCategory(selected ? category : null),
                                        );
                                      },
                                      selectedColor: Theme.of(context).colorScheme.primaryContainer,
                                      checkmarkColor: Theme.of(context).colorScheme.onPrimaryContainer,
                                    );
                                  }),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Malzemeleri Seçin',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    final category = categories[index];
                                    return _buildCategoryCard(
                                      context,
                                      category,
                                      selectedIngredients,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: selectedIngredients.isEmpty
                                      ? null
                                      : () {
                                          context.read<IngredientsBloc>().add(
                                                const IngredientsEvent.getRecipeByIngredients(),
                                              );
                                        },
                                  icon: const Icon(Icons.search, size: 24),
                                  label: Text(
                                    selectedIngredients.isEmpty
                                        ? 'Malzeme Seçin'
                                        : 'Ne Pişirsem? (${selectedIngredients.length})',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 18),
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
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    IngredientCategory category,
    List<String> selectedIngredients,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        leading: Text(
          category.icon,
          style: const TextStyle(fontSize: 28),
        ),
        title: Text(
          category.name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Text(
          '${category.items.length} malzeme',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: category.items.map((item) {
                final isSelected = selectedIngredients.contains(item.turkishName);
                return FilterChip(
                  label: Text(item.turkishName),
                  selected: isSelected,
                  onSelected: (selected) {
                    context.read<IngredientsBloc>().add(
                          IngredientsEvent.toggleIngredient(item.turkishName),
                        );
                  },
                  selectedColor: Theme.of(context).colorScheme.primaryContainer,
                  checkmarkColor: Theme.of(context).colorScheme.primary,
                  labelStyle: TextStyle(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : null,
                  ),
                  avatar: isSelected
                      ? Icon(
                          Icons.check_circle,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, Failure failure) {
    return Center(
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
              'Tarif Bulunamadı',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              failure.message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<IngredientsBloc>().add(
                      const IngredientsEvent.clearSelection(),
                    );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Farklı Malzemeler Dene'),
            ),
          ],
        ),
      ),
    );
  }
}
