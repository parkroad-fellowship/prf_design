import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/states/category_chips/_handset.dart';
import 'package:prf_design/src/widgets/states/category_chips/_tablet.dart';

/// A generic, reusable category chip selector widget.
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

  final List<T> categories;
  final void Function(T?) onCategorySelected;
  final String Function(T) labelBuilder;
  final T? selectedCategory;
  final bool isLoading;
  final bool showAllOption;
  final String allLabel;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFCategoryChipsTablet<T>(
        categories: categories,
        onCategorySelected: onCategorySelected,
        labelBuilder: labelBuilder,
        selectedCategory: selectedCategory,
        isLoading: isLoading,
        showAllOption: showAllOption,
        allLabel: allLabel,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFCategoryChipsHandset<T>(
          categories: categories,
          onCategorySelected: onCategorySelected,
          labelBuilder: labelBuilder,
          selectedCategory: selectedCategory,
          isLoading: isLoading,
          showAllOption: showAllOption,
          allLabel: allLabel,
        ),
        tablet: (_, _) => PRFCategoryChipsTablet<T>(
          categories: categories,
          onCategorySelected: onCategorySelected,
          labelBuilder: labelBuilder,
          selectedCategory: selectedCategory,
          isLoading: isLoading,
          showAllOption: showAllOption,
          allLabel: allLabel,
        ),
      ),
    );
  }
}
