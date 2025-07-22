import 'package:flutter/material.dart';
import 'package:flutter_meals_app/providers/favorites_provider.dart';
import 'package:flutter_meals_app/providers/filters_provider.dart';
import 'package:flutter_meals_app/screens/categories.dart';
import 'package:flutter_meals_app/screens/filters.dart';
import 'package:flutter_meals_app/screens/meals.dart';
import 'package:flutter_meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_meals_app/providers/meals_provider.dart';

const kInitialFilters = {
  FilterOptions.glutenFree: false,
  FilterOptions.lactoseFree: false,
  FilterOptions.vegetarian: false,
  FilterOptions.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // Manage set filters
  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // Close the drawer
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<FilterOptions, bool>>(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider); // Watch the meals provider

    final activeFilters = ref.watch(filtersProvider);
    final availableMeals =
        meals.where((meal) {
          if (activeFilters[FilterOptions.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (activeFilters[FilterOptions.lactoseFree]! &&
              !meal.isLactoseFree) {
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

    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoritesMeal = ref.watch(favoriteMealsProvider);

      activePage = MealsScreen(meals: favoritesMeal);
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      endDrawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
