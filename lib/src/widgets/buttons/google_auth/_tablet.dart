import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/_index.dart';
import 'package:prf_design/src/widgets/buttons/_button_styles.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';

class GoogleAuthButtonTablet extends StatelessWidget {
  const GoogleAuthButtonTablet({
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
      height: PRFButtonTokens.tabletHeight,
      child: OutlinedButton(
        onPressed: (disabled || (isLoading ?? false)) ? null : onPressed,
        style: PRFButtonStyles.google(theme, isTablet: true),
        child: Semantics(
          label: (isLoading ?? false)
              ? '$title, loading'
              : (disabled ? '$title, disabled' : title),
          button: true,
          enabled: !(disabled || (isLoading ?? false)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading ?? false)
                SizedBox(
                  height: PRFButtonTokens.tabletLoaderSize,
                  width: PRFButtonTokens.tabletLoaderSize,
                  child: PRFCircularProgressIndicator(
                    color: theme.colorScheme.primary,
                  ),
                )
              else if (googleLogoAsset != null)
                SizedBox(
                  height: PRFButtonTokens.tabletLoaderSize,
                  width: PRFButtonTokens.tabletLoaderSize,
                  child: googleLogoAsset,
                )
              else
                SizedBox(
                  width: PRFButtonTokens.tabletLoaderSize,
                  height: PRFButtonTokens.tabletLoaderSize,
                ),
              const SizedBox(width: PRFButtonTokens.tabletLoaderGap),
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
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
