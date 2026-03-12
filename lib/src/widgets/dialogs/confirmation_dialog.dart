import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/buttons/destroy/destroy.dart';
import 'package:prf_design/src/widgets/buttons/primary/primary.dart';
import 'package:prf_design/src/widgets/buttons/secondary/secondary.dart';

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

  final String title;
  final String? message;
  final Widget? content;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;
  final VoidCallback? onConfirm;
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
              color: isDestructive
                  ? theme.colorScheme.error
                  : theme.colorScheme.primary,
              size: 24,
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
      content: content ??
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
      PRFSecondaryButton(
        onPressed: () => Navigator.of(context).pop(false),
        title: cancelLabel,
        disabled: false,
      ),
      const SizedBox(width: PRFSpacingTokens.sm),
      if (isDestructive)
        PRFDestroyButton(
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop(true);
          },
          title: confirmLabel,
          disabled: false,
        )
      else
        PRFPrimaryButton(
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop(true);
          },
          title: confirmLabel,
          disabled: false,
        ),
    ];
  }
}
