import 'package:flutter/material.dart';
import 'package:dlgc_hymnal/core/components/components.dart';

class FilterTabContent extends StatelessWidget {
  final List<String> items;
  final Function(String) onItemSelected;
  final Set<String> selectedItems;

  const FilterTabContent({
    super.key,
    required this.items,
    required this.onItemSelected,
    required this.selectedItems,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Display 2 items per row
        childAspectRatio: 2.5, // Adjust this value to control button height
        crossAxisSpacing: 12, // Horizontal spacing between buttons
        mainAxisSpacing: 12, // Vertical spacing between buttons
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return FilterButton(
          label: item,
          isSelected: selectedItems.contains(item),
          onTap: () => onItemSelected(item),
        );
      },
    );
  }
}