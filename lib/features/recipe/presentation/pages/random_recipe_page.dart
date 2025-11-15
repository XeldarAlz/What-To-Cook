import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/error/failures.dart';
import '../bloc/recipe_bloc.dart';
import '../bloc/recipe_state.dart';
import '../bloc/recipe_event.dart';
import '../widgets/recipe_detail_widget.dart';
import '../widgets/loading_animation_widget.dart';

class RandomRecipePage extends StatelessWidget {
  const RandomRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RecipeBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<RecipeBloc, RecipeState>(
            builder: (context, state) {
              return state.maybeWhen(
                initial: () => _buildInitialView(context),
                loading: () => const LoadingAnimationWidget(),
                loaded: (recipe) => RecipeDetailWidget(recipe: recipe),
                error: (failure) => _buildErrorView(context, failure),
                orElse: () => _buildInitialView(context),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInitialView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant_menu,
            size: 80,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Text(
            'Bugün Ne Pişirsek?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 48),
          ElevatedButton.icon(
            onPressed: () {
              context.read<RecipeBloc>().add(const RecipeEvent.getRandomRecipe());
            },
            icon: const Icon(Icons.search, size: 28),
            label: const Text(
              'Ne Pişirsem?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
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
                context.read<RecipeBloc>().add(const RecipeEvent.getRandomRecipe());
              },
              child: const Text('Tekrar Dene'),
            ),
          ],
        ),
      ),
    );
  }
}

