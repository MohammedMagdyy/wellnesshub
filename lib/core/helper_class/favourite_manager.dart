import 'package:flutter/material.dart';
import '../models/fitness_plan/exercises_model.dart';
import '../services/favourite/addtofavourite_service.dart';
import '../services/favourite/removefavourite_service.dart';
import '../services/favourite/show_favourite_service.dart';

class FavoriteManager {
  FavoriteManager._privateConstructor();
  static final FavoriteManager instance = FavoriteManager._privateConstructor();

  final ValueNotifier<List<Exercise>> favorites = ValueNotifier<List<Exercise>>([]);

  // Keep a set of favorite IDs for quick checking
  final Set<int> favoriteIds = {};

  // Load favorites from backend
  Future<void> loadFavorites() async {
    try {
      final favs = await ShowFavouriteService().showFavourites();
      favorites.value = favs;
      favoriteIds
        ..clear()
        ..addAll(favs.map((e) => e.id));
    } catch (e) {
      favorites.value = [];
      favoriteIds.clear();
      // You may want to log or handle this error properly
      print("Failed to load favorites: $e");
    }
  }

  // Check if an exercise is favorited by its int ID
  bool isFavorite(int exerciseId) {
    return favoriteIds.contains(exerciseId);
  }

  // Add favorite, update backend and local state
  Future<void> addFavorite(Exercise exercise) async {
    try {
      await AddToFavouriteService().addToFav(exercise.id);
      // Update local state after success
      if (!favoriteIds.contains(exercise.id)) {
        favoriteIds.add(exercise.id);
        favorites.value = [...favorites.value, exercise];
      }
    } catch (e) {
      print("Failed to add favorite: $e");
      rethrow; // let caller handle error too
    }
  }

  // Remove favorite, update backend and local state
  Future<void> removeFavorite(Exercise exercise) async {
    try {
      await RemoveFromFavouriteService().removeFromFav(exercise.id);
      favoriteIds.remove(exercise.id);
      favorites.value = favorites.value.where((e) => e.id != exercise.id).toList();
    } catch (e) {
      print("Failed to remove favorite: $e");
      rethrow; // let caller handle error too
    }
  }
}
