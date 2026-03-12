import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

class PRFBottomSheet extends StatelessWidget {
  const PRFBottomSheet({
    required this.title,
    required this.child,
    super.key,
    this.showHandle = true,
    this.onClose,
  });

  final String title;
  final Widget child;
  final bool showHandle;
  final VoidCallback? onClose;

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
        return FractionallySizedBox(
          heightFactor: heightFactor,
          child: PRFBottomSheet(
            title: title,
            showHandle: showHandle,
            onClose: () => Navigator.pop(modalContext),
            child: child,
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
        children: [
          if (showHandle) ...[
            const SizedBox(height: PRFSpacingTokens.sm),
            Container(
              width: 56,
              height: 6,
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
          Expanded(child: child),
        ],
      ),
    );
  }
}
