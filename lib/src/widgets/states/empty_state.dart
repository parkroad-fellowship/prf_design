import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/buttons/primary/primary.dart';
import 'package:prf_design/src/widgets/navigation/branded_navbar.dart';

class PRFEmptyView extends StatelessWidget {
  const PRFEmptyView({
    required this.label,
    required this.description,
    this.icon,
    this.action,
    this.actionLabel,
    this.onActionPressed,
    this.navBarTitle,
    this.onBackPressed,
    this.showBackButton = true,
    this.navBarActions,
    this.navBarBackgroundColor,
    this.navBarForegroundColor,
    super.key,
  });

  final String label;
  final String description;
  final IconData? icon;
  final Widget? action;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final String? navBarTitle;
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final List<Widget>? navBarActions;
  final Color? navBarBackgroundColor;
  final Color? navBarForegroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final body = Semantics(
      label: '$label. $description',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon ?? Icons.inbox_outlined,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                )
                .animate()
                .fadeIn(duration: PRFMotionTokens.enterShort)
                .scale(delay: PRFMotionTokens.stagger2),
            const SizedBox(height: 16),
            Text(
                  label,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                )
                .animate()
                .fadeIn(delay: PRFMotionTokens.stagger3)
                .slideY(begin: 0.3, end: 0),
            const SizedBox(height: 8),
            Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.7,
                    ),
                  ),
                  textAlign: TextAlign.center,
                )
                .animate()
                .fadeIn(delay: PRFMotionTokens.stagger4)
                .slideY(begin: 0.3, end: 0),
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ] else if (actionLabel != null && onActionPressed != null) ...[
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PRFSpacingTokens.lg,
                ),
                child:
                    PRFPrimaryButton(
                          onPressed: onActionPressed!,
                          title: actionLabel!,
                          disabled: false,
                        )
                        .animate()
                        .fadeIn(delay: PRFMotionTokens.stagger5)
                        .scale(delay: PRFMotionTokens.stagger1),
              ),
            ],
          ],
        ),
      ),
    );

    if (navBarTitle == null) {
      return body;
    }

    return Column(
      children: [
        PRFBrandedNavBar(
          title: navBarTitle!,
          onBack: onBackPressed,
          showBackButton: showBackButton,
          actions: navBarActions,
          backgroundColor: navBarBackgroundColor,
          foregroundColor: navBarForegroundColor,
        ),
        Expanded(child: body),
      ],
    );
  }
}
