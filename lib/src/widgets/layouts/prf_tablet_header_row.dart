import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';

/// Tablet screen header: back navigation, an ellipsizing title that absorbs
/// long localizations, an optional inline loading spinner slot, and trailing
/// actions.
///
/// ```dart
/// PRFTabletHeaderRow(
///   title: l10n.missions,
///   onBack: () => context.router.popUntilRouteWithPath(route),
///   isLoading: isLoading,
/// )
/// ```
class PRFTabletHeaderRow extends StatelessWidget {
  const PRFTabletHeaderRow({
    required this.title,
    super.key,
    this.onBack,
    this.isLoading = false,
    this.trailing = const [],
    this.padding = const EdgeInsets.all(PRFSpacingTokens.lg),
  });

  /// Screen title rendered in headlineMedium bold.
  final String title;

  /// Back handler. When null the back button is hidden (top-level screens).
  final VoidCallback? onBack;

  /// Shows a compact 24px spinner in the header while data loads, so counts
  /// and lists never flash empty mid-reload.
  final bool isLoading;

  /// Extra widgets after the title (refresh buttons, badges, filters).
  final List<Widget> trailing;

  /// Outer padding. Defaults to [PRFSpacingTokens.lg] on all sides.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding,
      child: Row(
        children: [
          if (onBack != null) ...[
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBack,
            ),
            const SizedBox(width: PRFSpacingTokens.xs),
          ],
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          if (isLoading)
            const SizedBox.square(
              dimension: 24,
              child: PRFCircularProgressIndicator(),
            ),
          ...trailing,
        ],
      ),
    );
  }
}
