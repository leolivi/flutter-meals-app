import 'package:flutter_meals_app/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FilterOptions { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<FilterOptions, bool>> {
  FiltersNotifier()
    : super({
        FilterOptions.glutenFree: false,
        FilterOptions.lactoseFree: false,
        FilterOptions.vegetarian: false,
        FilterOptions.vegan: false,
      });

  void setFilter(FilterOptions filter, bool isActive) {
    state = {
      ...state, // copy existing filters
      filter: isActive,
    };
  }

  void setFilters(Map<FilterOptions, bool> filters) {
    state = filters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<FilterOptions, bool>>((ref) {
      return FiltersNotifier();
    });

// Provider to filter meals based on active filters
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[FilterOptions.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[FilterOptions.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[FilterOptions.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[FilterOptions.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
