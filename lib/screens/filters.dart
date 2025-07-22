import 'package:flutter/material.dart';
import 'package:flutter_meals_app/widgets/switch_list_tile.dart';

enum FilterOptions { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<FilterOptions, bool> currentFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[FilterOptions.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[FilterOptions.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[FilterOptions.vegetarian]!;
    _veganFilterSet = widget.currentFilters[FilterOptions.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      // endDrawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop(); // Close the drawer
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (ctx) => TabsScreen()),
      //       );
      //     }
      //   },
      // ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            FilterOptions.glutenFree: _glutenFreeFilterSet,
            FilterOptions.lactoseFree: _lactoseFreeFilterSet,
            FilterOptions.vegetarian: _vegetarianFilterSet,
            FilterOptions.vegan: _veganFilterSet,
          });
          return false; // Prevents the screen from popping twice
        },
        child: Column(
          children: [
            SwitchListTileWidget(
              value: _glutenFreeFilterSet,
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals.',
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
            ),
            SwitchListTileWidget(
              value: _lactoseFreeFilterSet,
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals.',
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
            ),
            SwitchListTileWidget(
              value: _vegetarianFilterSet,
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
            ),
            SwitchListTileWidget(
              value: _veganFilterSet,
              title: 'Vegan',
              subtitle: 'Only include vegan meals.',
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
