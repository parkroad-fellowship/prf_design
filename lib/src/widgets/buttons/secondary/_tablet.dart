import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/_index.dart';
import 'package:prf_design/src/widgets/buttons/_button_styles.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';

class PRFSecondaryButtonTablet extends StatelessWidget {
  const PRFSecondaryButtonTablet({
    required this.onPressed,
    required this.title,
    required this.disabled,
    super.key,
    this.isLoading,
  });

  final VoidCallback onPressed;
  final String title;
  final bool disabled;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: PRFButtonTokens.tabletHeight,
      child: OutlinedButton(
        onPressed: (disabled || (isLoading ?? false)) ? null : onPressed,
        style: PRFButtonStyles.secondary(theme, isTablet: true),
        child: Semantics(
          label: (isLoading ?? false)
              ? '$title, loading'
              : (disabled ? '$title, disabled' : title),
          button: true,
          enabled: !(disabled || (isLoading ?? false)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading ?? false) ...[
                SizedBox(
                  height: PRFButtonTokens.tabletLoaderSize,
                  width: PRFButtonTokens.tabletLoaderSize,
                  child: PRFCircularProgressIndicator(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: PRFButtonTokens.tabletLoaderGap),
              ],
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
