import 'package:flutter/material.dart';

/// Shared body for PRFFormFieldLabel variants.
///
/// Label and "(optional)" hint use `onSurfaceVariant`, which clears WCAG AA
/// on PRF surfaces in both brightness modes. The required marker uses
/// `colorScheme.error`.
Widget buildFormFieldLabel(
  BuildContext context, {
  required String label,
  bool? isRequired,
  Color? color,
}) {
  final theme = Theme.of(context);
  final scheme = theme.colorScheme;
  final required = isRequired ?? false;

  return Semantics(
    label: required ? '$label, required field' : '$label, optional field',
    child: RichText(
      text: TextSpan(
        text: label.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: color ?? scheme.onSurfaceVariant,
          letterSpacing: 0.5,
        ),
        children: [
          if (required)
            TextSpan(
              text: ' *',
              style: theme.textTheme.labelSmall?.copyWith(
                color: scheme.error,
                fontWeight: FontWeight.w700,
              ),
            )
          else
            TextSpan(
              text: ' (optional)',
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    ),
  );
}
