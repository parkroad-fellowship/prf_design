import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/_index.dart';
import 'package:prf_design/src/widgets/buttons/_button_styles.dart';
import 'package:prf_design/src/widgets/buttons/_interactive_button_shell.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';

class PRFDestroyButtonHandset extends StatelessWidget {
  const PRFDestroyButtonHandset({
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
      height: PRFButtonTokens.handsetHeight,
      enabled: isInteractive,
      child: ElevatedButton(
        onPressed: isInteractive ? onPressed : null,
        style: PRFButtonStyles.primary(
          theme,
          isTablet: false,
          backgroundColor: theme.colorScheme.error,
          foregroundColor: theme.colorScheme.onError,
        ),
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
                  height: PRFButtonTokens.handsetLoaderSize,
                  width: PRFButtonTokens.handsetLoaderSize,
                  child: PRFCircularProgressIndicator(
                    color: theme.colorScheme.onError,
                  ),
                ),
                const SizedBox(width: PRFButtonTokens.handsetLoaderGap),
              ],
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onError,
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
