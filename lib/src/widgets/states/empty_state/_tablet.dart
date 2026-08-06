import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/buttons/prf_button.dart';
import 'package:prf_design/src/widgets/navigation/branded_navbar.dart';
import 'package:prf_design/src/widgets/states/empty_state/_shared.dart';

/// Tablet layout for PRFEmptyView. Internal — prefer the parent widget.
class PRFEmptyViewTablet extends StatelessWidget {
  const PRFEmptyViewTablet({
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

  bool get _hasAction =>
      action != null || (actionLabel != null && onActionPressed != null);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final body = Semantics(
      label: '$label. $description',
      child: Center(
        child: ConstrainedBox(
          // tablet content is width-constrained for comfortable reading
          constraints: const BoxConstraints(maxWidth: 560),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PRFSpacingTokens.xxxl,
              vertical: PRFSpacingTokens.xl,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildEmptyIcon(
                  context,
                  theme: theme,
                  icon: icon ?? Icons.inbox_outlined,
                  size: PRFSizeTokens.iconHero,
                  containerPadding: PRFSpacingTokens.xxxl,
                ),
                const SizedBox(height: PRFSpacingTokens.xl),
                buildEmptyLabel(context, theme: theme, label: label),
                const SizedBox(height: PRFSpacingTokens.md),
                buildEmptyDescription(
                  context,
                  theme: theme,
                  description: description,
                ),
                if (_hasAction) ...[
                  const SizedBox(height: PRFSpacingTokens.xxxl),
                  // tablet: action button is constrained to 320 px and centred
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 320),
                    child: buildEmptyAction(
                      context,
                      action: action,
                      actionButton: action == null && actionLabel != null
                          ? PRFButton(
                              onPressed: onActionPressed!,
                              title: actionLabel!,
                            )
                          : null,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    if (navBarTitle == null) return body;
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
