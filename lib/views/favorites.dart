import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import '../core/helper_class/favourite_manager.dart';
import '../core/models/fitness_plan/exercises_model.dart';
import '../core/widgets/ExerciseCard.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  static const routeName = 'Favorites';

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    // Load favorites initially
    FavoriteManager.instance.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:  isDark? darkBackgroundColor :lightBackgroundColor,
      body: SafeArea(
        child: ValueListenableBuilder<List<Exercise>>(
          valueListenable: FavoriteManager.instance.favorites,
          builder: (context, exercises, child) {
            if (exercises.isEmpty) {
              return Center(
                child: Text(
                  'No favourite exercises found.',
                  style: TextStyle(
                    fontSize: 22,
                    color: isDark? darkPrimaryTextColor : lightPrimaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  expandedHeight: 120.0,
                  backgroundColor: isDark? darkBackgroundColor : lightBackgroundColor,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
                    title: Text(
                      'Favourites Exercises',
                      style: TextStyle(
                        color: isDark? darkPrimaryTextColor : lightPrimaryTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final exercise = exercises[index];
                      final isFav = FavoriteManager.instance.isFavorite(exercise.id);

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ExerciseCard(
                          isFav: true,
                          exercise: exercise,
                          isFavorite: isFav,
                          onFavoriteToggle: () async {
                            if (isFav) {
                              await FavoriteManager.instance.removeFavorite(exercise);
                            } else {
                              await FavoriteManager.instance.addFavorite(exercise);
                            }
                          },
                        ),
                      );
                    },
                    childCount: exercises.length,
                  ),
                ),

              ],
            );
          },
        ),
      ),
    );
  }
}
