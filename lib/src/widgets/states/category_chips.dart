import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/widgets/states/category_chips/_handset.dart';
import 'package:prf_design/src/widgets/states/category_chips/_tablet.dart';

/// A generic, reusable category chip selector widget.
///
/// Renders a horizontally scrollable row of chips, one per [categories] item,
/// plus an optional "ALL" chip. Selecting a chip calls [onCategorySelected]
/// with the item — or `null` for the "ALL" chip.
///
/// Usage:
/// ```dart
/// PRFCategoryChips<MyCategory>(
///   categories: myCategories,
///   selectedCategory: _selected,
///   onCategorySelected: (category) => setState(() => _selected = category),
///   labelBuilder: (category) => category.name,
/// )
/// ```
class PRFCategoryChips<T> extends StatelessWidget {
  const PRFCategoryChips({
    required this.categories,
    required this.onCategorySelected,
    required this.labelBuilder,
    this.selectedCategory,
    this.isLoading = false,
    this.showAllOption = true,
    this.allLabel = 'ALL',
    super.key,
  });

  /// The items rendered as chips.
  final List<T> categories;

  /// Invoked when a chip is selected — `null` for the "ALL" chip.
  final void Function(T?) onCategorySelected;

  /// Builds the chip label for a category.
  final String Function(T) labelBuilder;

  /// The currently selected category; highlighted chip.
  final T? selectedCategory;

  /// When true the chips are replaced by loading placeholders.
  final bool isLoading;

  /// When true a leading "ALL" chip is rendered. Defaults to true.
  final bool showAllOption;

  /// Label of the "ALL" chip. Defaults to `ALL`.
  final String allLabel;

  @override
  Widget build(BuildContext context) {
    return PRFAdaptive(
      handset: (_) => PRFCategoryChipsHandset<T>(
        categories: categories,
        onCategorySelected: onCategorySelected,
        labelBuilder: labelBuilder,
        selectedCategory: selectedCategory,
        isLoading: isLoading,
        showAllOption: showAllOption,
        allLabel: allLabel,
      ),
      tablet: (_) => PRFCategoryChipsTablet<T>(
        categories: categories,
        onCategorySelected: onCategorySelected,
        labelBuilder: labelBuilder,
        selectedCategory: selectedCategory,
        isLoading: isLoading,
        showAllOption: showAllOption,
        allLabel: allLabel,
      ),
      builder: (_, _) => PRFCategoryChipsTablet<T>(
        categories: categories,
        onCategorySelected: onCategorySelected,
        labelBuilder: labelBuilder,
        selectedCategory: selectedCategory,
        isLoading: isLoading,
        showAllOption: showAllOption,
        allLabel: allLabel,
      ),
    );
  }
}
