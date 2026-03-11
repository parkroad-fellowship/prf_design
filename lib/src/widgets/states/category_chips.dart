import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/progress/linear_progress_indicator.dart';

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
    this.height = 48,
    this.spacing = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    super.key,
  });

  /// The list of categories to display
  final List<T> categories;

  /// Callback when a category is selected. Null means "All" was selected.
  final void Function(T?) onCategorySelected;

  /// Function to get the display label from a category
  final String Function(T) labelBuilder;

  /// The currently selected category. Null means "All" is selected.
  final T? selectedCategory;

  /// Whether to show a loading indicator
  final bool isLoading;

  /// Whether to show the "All" option at the beginning
  final bool showAllOption;

  /// Label for the "All" option
  final String allLabel;

  /// Height of the chip container
  final double height;

  /// Spacing between chips
  final double spacing;

  /// Padding around the list
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isLoading) {
      return Padding(
        padding: padding,
        child: const PRFLinearProgressIndicator(),
      );
    }

    if (categories.isEmpty && !showAllOption) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: padding,
      child: SizedBox(
        height: height,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length + (showAllOption ? 1 : 0),
          separatorBuilder: (context, index) => SizedBox(width: spacing),
          itemBuilder: (context, index) {
            final isAll = showAllOption && index == 0;
            final categoryIndex = showAllOption ? index - 1 : index;
            final isSelected = isAll
                ? selectedCategory == null
                : selectedCategory == categories[categoryIndex];

            final label = isAll
                ? allLabel
                : labelBuilder(categories[categoryIndex]).toUpperCase();

            final selectedColor = theme.colorScheme.primary;
            final unselectedColor = theme.colorScheme.surface;
            final selectedTextColor = theme.colorScheme.onPrimary;
            final unselectedTextColor = theme.colorScheme.primary;

            return Semantics(
              button: true,
              label: label,
              selected: isSelected,
              child: GestureDetector(
                onTap: () {
                  onCategorySelected(isAll ? null : categories[categoryIndex]);
                },
                child:
                    AnimatedContainer(
                          duration: PRFMotionTokens.standard,
                          curve: Curves.easeOut,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? selectedColor : unselectedColor,
                            borderRadius: BorderRadius.circular(
                              PRFRadiusTokens.lg,
                            ),
                            border: Border.all(
                              color: isSelected
                                  ? selectedColor.withValues(alpha: .5)
                                  : theme.colorScheme.outline.withValues(
                                      alpha: .3,
                                    ),
                              width: 1.2,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: selectedColor.withValues(
                                        alpha: .13,
                                      ),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              label,
                              style: theme.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? selectedTextColor
                                    : unselectedTextColor,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        )
                        .animate(target: isSelected ? 1 : 0)
                        .scaleXY(
                          begin: 1,
                          end: 1.06,
                          duration: PRFMotionTokens.standard,
                          curve: Curves.easeOut,
                        ),
              ),
            );
          },
        ),
      ),
    );
  }
}
