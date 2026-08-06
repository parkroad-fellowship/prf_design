import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Rounded modal bottom sheet with a handle, title, close button and body.
///
/// Pushes itself with [PRFBottomSheet.show]. `heightFactor` sizes the sheet to
/// a fraction of the screen and it stays above the keyboard. The body [child]
/// scrolls while the header stays fixed.
///
/// Example:
/// ```dart
/// final result = await PRFBottomSheet.show<Report>(
///   context,
///   title: 'Generate report',
///   heightFactor: 0.7,
///   child: ReportForm(onSubmit: (r) => Navigator.pop(context, r)),
/// );
/// ```
class PRFBottomSheet extends StatelessWidget {
  const PRFBottomSheet({
    required this.title,
    required this.child,
    super.key,
    this.showHandle = true,
    this.onClose,
  });

  /// Header title.
  final String title;

  /// Body content below the header divider.
  final Widget child;

  /// When false the drag handle is hidden. Defaults to true.
  final bool showHandle;

  /// Invoked when the close button is pressed; defaults to `pop`.
  final VoidCallback? onClose;

  /// Presents the sheet modally and resolves with the sheet's result.
  ///
  /// [heightFactor] sets the maximum sheet height as a fraction of the screen.
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required Widget child,
    double heightFactor = 0.94,
    bool useSafeArea = true,
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool enableDrag = true,
    bool showHandle = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
        final keyboardInset = MediaQuery.viewInsetsOf(modalContext).bottom;
        final screenHeight = MediaQuery.sizeOf(modalContext).height;
        final maxHeight = (screenHeight * heightFactor) - keyboardInset;

        return Padding(
          padding: EdgeInsets.only(bottom: keyboardInset),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: maxHeight > 100 ? maxHeight : 100,
            ),
            child: PRFBottomSheet(
              title: title,
              showHandle: showHandle,
              onClose: () => Navigator.pop(modalContext),
              child: child,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showHandle) ...[
            const SizedBox(height: PRFSpacingTokens.sm),
            Container(
              width: PRFSizeTokens.bottomSheetHandleWidth,
              height: PRFSizeTokens.bottomSheetHandleHeight,
              decoration: BoxDecoration(
                color: theme.colorScheme.outline.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(PRFRadiusTokens.full),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.fromLTRB(
              PRFSpacingTokens.lg,
              PRFSpacingTokens.md,
              PRFSpacingTokens.sm,
              PRFSpacingTokens.md,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: theme.colorScheme.primary,
                  ),
                  onPressed: onClose ?? () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Divider(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            height: 1,
          ),
          Flexible(child: child),
        ],
      ),
    );
  }
}
