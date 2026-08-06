import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/progress/linear_progress_indicator.dart';
import 'package:prf_design/src/widgets/states/category_chips/_shared.dart';

class PRFCategoryChipsHandset<T> extends StatelessWidget {
  const PRFCategoryChipsHandset({
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
    final theme = Theme.of(context);

    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: PRFSpacingTokens.lg),
        child: PRFLinearProgressIndicator(),
      );
    }

    if (categories.isEmpty && !showAllOption) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PRFSpacingTokens.lg),
      child: SizedBox(
        height: PRFSizeTokens.minTouchTarget,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length + (showAllOption ? 1 : 0),
          separatorBuilder: (_, _) =>
              const SizedBox(width: PRFSpacingTokens.sm),
          itemBuilder: (context, index) {
            final isAll = showAllOption && index == 0;
            final catIndex = showAllOption ? index - 1 : index;
            final isSelected = isAll
                ? selectedCategory == null
                : selectedCategory == categories[catIndex];
            final label = isAll
                ? allLabel
                : labelBuilder(categories[catIndex]).toUpperCase();

            return buildCategoryChip(
              context,
              theme: theme,
              label: label,
              isSelected: isSelected,
              onTap: () => onCategorySelected(
                isAll ? null : categories[catIndex],
              ),
            );
          },
        ),
      ),
    );
  }
}
