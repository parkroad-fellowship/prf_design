import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/_index.dart';
import 'package:prf_design/src/widgets/buttons/_button_styles.dart';

class PRFPrimaryButtonHandset extends StatelessWidget {
  const PRFPrimaryButtonHandset({
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
      child: ElevatedButton(
        onPressed: (disabled || (isLoading ?? false)) ? null : onPressed,
        style: PRFButtonStyles.primary(theme, isTablet: false),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading ?? false) ...[
              SizedBox(
                height: PRFButtonTokens.handsetLoaderSize,
                width: PRFButtonTokens.handsetLoaderSize,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: PRFButtonTokens.strokeWidthHandset,
                ),
              ),
              const SizedBox(width: PRFButtonTokens.handsetLoaderGap),
            ],
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
