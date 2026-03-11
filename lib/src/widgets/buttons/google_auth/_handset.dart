import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/_index.dart';
import 'package:prf_design/src/widgets/buttons/_button_styles.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';

class GoogleAuthButtonHandset extends StatelessWidget {
  const GoogleAuthButtonHandset({
    required this.onPressed,
    required this.title,
    required this.disabled,
    super.key,
    this.isLoading,
    this.googleLogoAsset,
  });

  final VoidCallback onPressed;
  final String title;
  final bool disabled;
  final bool? isLoading;
  final Widget? googleLogoAsset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: PRFButtonTokens.handsetHeight,
      child: OutlinedButton(
        onPressed: (disabled || (isLoading ?? false)) ? null : onPressed,
        style: PRFButtonStyles.google(theme, isTablet: false),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading ?? false)
              SizedBox(
                height: PRFButtonTokens.handsetLoaderSize,
                width: PRFButtonTokens.handsetLoaderSize,
                child: PRFCircularProgressIndicator(
                  color: theme.colorScheme.primary,
                ),
              )
            else if (googleLogoAsset != null)
              SizedBox(
                height: PRFButtonTokens.handsetLoaderSize,
                width: PRFButtonTokens.handsetLoaderSize,
                child: googleLogoAsset,
              )
            else
              SizedBox(
                width: PRFButtonTokens.handsetLoaderSize,
                height: PRFButtonTokens.handsetLoaderSize,
              ),
            const SizedBox(width: PRFButtonTokens.handsetLoaderGap),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
