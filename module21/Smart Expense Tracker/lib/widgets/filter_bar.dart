import 'package:flutter/material.dart';

import '../controllers/expense_controller.dart';
import '../models/expense.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key, required this.controller});

  final ExpenseController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final filter in ExpenseFilter.values)
              ChoiceChip(
                label: Text(filter.label),
                selected: controller.filter == filter,
                onSelected: (_) => controller.setFilter(filter),
              ),
          ],
        ),
        if (controller.filter == ExpenseFilter.byCategory)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                const Text('Category: '),
                const SizedBox(width: 8),
                DropdownButton<ExpenseCategory>(
                  value: controller.filterCategory,
                  items: [
                    for (final category in ExpenseCategory.values)
                      DropdownMenuItem(
                        value: category,
                        child: Row(
                          children: [
                            Icon(
                              category.icon,
                              color: category.color,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(category.label),
                          ],
                        ),
                      ),
                  ],
                  onChanged: (category) {
                    if (category != null) {
                      controller.setFilterCategory(category);
                    }
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
