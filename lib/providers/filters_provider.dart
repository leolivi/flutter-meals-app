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
