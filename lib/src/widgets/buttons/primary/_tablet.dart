import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/_index.dart';
import 'package:prf_design/src/widgets/buttons/_button_styles.dart';
import 'package:prf_design/src/widgets/buttons/_interactive_button_shell.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';

class PRFPrimaryButtonTablet extends StatelessWidget {
  const PRFPrimaryButtonTablet({
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
    final isInteractive = !(disabled || (isLoading ?? false));

    return PRFInteractiveButtonShell(
      height: PRFButtonTokens.tabletHeight,
      enabled: isInteractive,
      child: ElevatedButton(
        onPressed: isInteractive ? onPressed : null,
        style: PRFButtonStyles.primary(theme, isTablet: true),
        child: Semantics(
          label: (isLoading ?? false)
              ? '$title, loading'
              : (disabled ? '$title, disabled' : title),
          container: true,
          excludeSemantics: true,
          button: true,
          enabled: isInteractive,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading ?? false) ...[
                SizedBox(
                  height: PRFButtonTokens.tabletLoaderSize,
                  width: PRFButtonTokens.tabletLoaderSize,
                  child: PRFCircularProgressIndicator(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(width: PRFButtonTokens.tabletLoaderGap),
              ],
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
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
