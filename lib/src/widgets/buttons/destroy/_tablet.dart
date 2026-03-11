import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/_index.dart';
import 'package:prf_design/src/widgets/buttons/_button_styles.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';

class PRFDestroyButtonTablet extends StatelessWidget {
  const PRFDestroyButtonTablet({
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
      child: ElevatedButton(
        onPressed: (disabled || (isLoading ?? false)) ? null : onPressed,
        style: PRFButtonStyles.primary(
          theme,
          isTablet: true,
          backgroundColor: theme.colorScheme.error,
          foregroundColor: theme.colorScheme.onError,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading ?? false) ...[
              SizedBox(
                height: PRFButtonTokens.tabletLoaderSize,
                width: PRFButtonTokens.tabletLoaderSize,
                child: PRFCircularProgressIndicator(color: Colors.white),
              ),
              const SizedBox(width: PRFButtonTokens.tabletLoaderGap),
            ],
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onError,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
