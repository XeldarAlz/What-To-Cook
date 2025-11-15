import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/error/failures.dart';
import '../bloc/ingredients_bloc.dart';
import '../bloc/ingredients_state.dart';
import '../bloc/ingredients_event.dart';
import '../../../recipe/presentation/widgets/recipe_detail_widget.dart';
import '../../../recipe/presentation/widgets/loading_animation_widget.dart';

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
                initial: (selected, available) => _buildIngredientsSelectionView(
                  context,
                  selected,
                  available,
                ),
                loading: (selected, available) => Column(
                  children: [
                    _buildIngredientsSelectionView(context, selected, available),
                    const Expanded(child: LoadingAnimationWidget()),
                  ],
                ),
                loaded: (recipe, selected, available) => Column(
                  children: [
                    _buildIngredientsSelectionView(context, selected, available),
                    Expanded(
                      child: RecipeDetailWidget(recipe: recipe),
                    ),
                  ],
                ),
                error: (failure, selected, available) => Column(
                  children: [
                    _buildIngredientsSelectionView(context, selected, available),
                    Expanded(
                      child: _buildErrorView(context, failure),
                    ),
                  ],
                ),
                orElse: () => _buildIngredientsSelectionView(context, [], []),
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
    List<String> availableIngredients,
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Evdeki Malzemeler',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: availableIngredients.map((ingredient) {
              final isSelected = selectedIngredients.contains(ingredient);
              return FilterChip(
                label: Text(ingredient),
                selected: isSelected,
                onSelected: (selected) {
                  context.read<IngredientsBloc>().add(
                        IngredientsEvent.toggleIngredient(ingredient),
                      );
                },
                selectedColor: Theme.of(context).colorScheme.primaryContainer,
                checkmarkColor: Theme.of(context).colorScheme.onPrimaryContainer,
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: selectedIngredients.isEmpty
                      ? null
                      : () {
                          context.read<IngredientsBloc>().add(
                                const IngredientsEvent.getRecipeByIngredients(),
                              );
                        },
                  icon: const Icon(Icons.search),
                  label: const Text(
                    'Ne Pişirsem?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              if (selectedIngredients.isNotEmpty) ...[
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    context.read<IngredientsBloc>().add(
                          const IngredientsEvent.clearSelection(),
                        );
                  },
                  icon: const Icon(Icons.clear),
                  tooltip: 'Temizle',
                ),
              ],
            ],
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
              'Bir hata oluştu',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              failure.message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

