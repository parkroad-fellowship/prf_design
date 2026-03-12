import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prf_design/src/theme/_index.dart';
import 'package:prf_design/src/widgets/buttons/_button_styles.dart';
import 'package:prf_design/src/widgets/buttons/_interactive_button_shell.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';

class PRFGoogleAuthButtonHandset extends StatelessWidget {
  const PRFGoogleAuthButtonHandset({
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
      child: OutlinedButton(
        onPressed: isInteractive ? onPressed : null,
        style: PRFButtonStyles.google(theme, isTablet: false),
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
              if (isLoading ?? false)
                SizedBox(
                  height: PRFButtonTokens.handsetLoaderSize,
                  width: PRFButtonTokens.handsetLoaderSize,
                  child: PRFCircularProgressIndicator(
                    color: theme.colorScheme.primary,
                  ),
                )
              else
                SizedBox(
                  height: PRFButtonTokens.handsetLoaderSize,
                  width: PRFButtonTokens.handsetLoaderSize,
                  child: SvgPicture.asset(
                    'assets/authentication/google_logo.svg',
                    package: 'prf_design',
                  ),
                ),
              const SizedBox(width: PRFButtonTokens.handsetLoaderGap),
              Flexible(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
