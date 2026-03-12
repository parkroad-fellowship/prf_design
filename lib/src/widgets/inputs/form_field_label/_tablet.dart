import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';

class PRFFormFieldLabelTablet extends StatelessWidget {
  const PRFFormFieldLabelTablet({
    required this.label,
    super.key,
    this.isRequired,
    this.color,
    this.isBold,
  });

  final String label;
  final bool? isRequired;
  final Color? color;
  final bool? isBold;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: (isRequired ?? false)
          ? '$label, required field'
          : '$label, optional field',
      child: RichText(
        text: TextSpan(
          text: label.toUpperCase(),
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: color ?? PRFColors.gray500,
            letterSpacing: 0.5,
          ),
          children: [
            if (isRequired ?? false)
              TextSpan(
                text: ' *',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.error,
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (isRequired == null || isRequired == false)
              TextSpan(
                text: ' (optional)',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: PRFColors.gray400,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
