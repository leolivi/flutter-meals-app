import 'package:flutter/material.dart';
import 'package:flutter_meals_app/providers/filters_provider.dart';
import 'package:flutter_meals_app/widgets/switch_list_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      body: Column(
        children: [
          SwitchListTileWidget(
            value: activeFilters[FilterOptions.glutenFree]!,
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(FilterOptions.glutenFree, isChecked);
            },
          ),
          SwitchListTileWidget(
            value: activeFilters[FilterOptions.lactoseFree]!,
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(FilterOptions.lactoseFree, isChecked);
            },
          ),
          SwitchListTileWidget(
            value: activeFilters[FilterOptions.vegetarian]!,
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals.',
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(FilterOptions.vegetarian, isChecked);
            },
          ),
          SwitchListTileWidget(
            value: activeFilters[FilterOptions.vegan]!,
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(FilterOptions.vegan, isChecked);
            },
          ),
        ],
      ),
    );
  }
}
