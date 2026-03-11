import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/_index.dart';
import 'package:prf_design/src/widgets/buttons/_button_styles.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';

class PRFSecondaryButtonHandset extends StatelessWidget {
  const PRFSecondaryButtonHandset({
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
      height: PRFButtonTokens.handsetHeight,
      child: OutlinedButton(
        onPressed: (disabled || (isLoading ?? false)) ? null : onPressed,
        style: PRFButtonStyles.secondary(theme, isTablet: false),
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
                  height: PRFButtonTokens.handsetLoaderSize,
                  width: PRFButtonTokens.handsetLoaderSize,
                  child: PRFCircularProgressIndicator(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: PRFButtonTokens.handsetLoaderGap),
              ],
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
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
