import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/buttons/prf_button.dart';

/// Confirmation dialog with icon header and confirm/cancel actions.
///
/// Pushes itself with [PRFConfirmationDialog.show]. The confirm button uses
/// the destructive style when [isDestructive] is true. Resolves `true` when
/// confirmed, `false` when cancelled. Pass [customActions] to replace the
/// default buttons entirely.
///
/// Example:
/// ```dart
/// final confirmed = await PRFConfirmationDialog.show<bool>(
///   context,
///   title: 'Delete mission?',
///   message: 'This action cannot be undone.',
///   confirmLabel: 'Delete',
///   isDestructive: true,
///   onConfirm: _deleteMission,
/// );
/// ```
class PRFConfirmationDialog extends StatelessWidget {
  const PRFConfirmationDialog({
    required this.title,
    super.key,
    this.message,
    this.content,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.isDestructive = false,
    this.onConfirm,
    this.customActions,
  });

  /// Dialog title shown beside the icon.
  final String title;

  /// Optional body text (ignored when [content] is provided).
  final String? message;

  /// Optional custom body widget (takes precedence over [message]).
  final Widget? content;

  /// Label of the confirm button. Defaults to `Confirm`.
  final String confirmLabel;

  /// Label of the cancel button. Defaults to `Cancel`.
  final String cancelLabel;

  /// When true the header icon and confirm button use the destructive style.
  final bool isDestructive;

  /// Invoked before the dialog closes with `true`.
  final VoidCallback? onConfirm;

  /// Replaces the default confirm/cancel buttons.
  final List<Widget>? customActions;

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    String? message,
    Widget? content,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
    VoidCallback? onConfirm,
    List<Widget>? customActions,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => PRFConfirmationDialog(
        title: title,
        message: message,
        content: content,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
        onConfirm: onConfirm,
        customActions: customActions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PRFRadiusTokens.xl),
      ),
      actionsOverflowButtonSpacing: PRFSpacingTokens.md,
      actionsPadding: const EdgeInsets.fromLTRB(
        PRFSpacingTokens.lg,
        PRFSpacingTokens.sm,
        PRFSpacingTokens.lg,
        PRFSpacingTokens.lg,
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(PRFSpacingTokens.sm),
            decoration: BoxDecoration(
              color: isDestructive
                  ? theme.colorScheme.errorContainer
                  : theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
            ),
            child: Icon(
              isDestructive ? Icons.delete_outline : Icons.info_outline,
              // error on errorContainer (not errorContainer on errorContainer)
              color: isDestructive
                  ? theme.colorScheme.error
                  : theme.colorScheme.primary,
              size: PRFSizeTokens.iconLg,
            ),
          ),
          const SizedBox(width: PRFSpacingTokens.lg),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      content:
          content ??
          (message != null
              ? Text(
                  message!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              : null),
      actions: customActions ?? _buildDefaultActions(context),
    );
  }

  List<Widget> _buildDefaultActions(BuildContext context) {
    return [
      PRFButton(
        onPressed: () => Navigator.of(context).pop(false),
        title: cancelLabel,
        variant: PRFButtonVariant.secondary,
      ),
      if (isDestructive)
        PRFButton(
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop(true);
          },
          title: confirmLabel,
          variant: PRFButtonVariant.destructive,
        )
      else
        PRFButton(
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop(true);
          },
          title: confirmLabel,
        ),
    ];
  }
}
