import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prf_design/src/widgets/inputs/_capitalization.dart';

class PRFTextAreaInputHandset extends StatelessWidget {
  const PRFTextAreaInputHandset({
    required this.hintText,
    required this.controller,
    super.key,
    this.enabled = true,
    this.labelText,
    this.errorText,
    this.helperText,
    this.maxLines = 5,
    this.minLines = 3,
    this.textInputAction = TextInputAction.newline,
    this.normalizeLeadingCapitalization = true,
  });

  final String hintText;
  final TextEditingController controller;
  final bool enabled;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final int minLines;
  final int maxLines;
  final TextInputAction textInputAction;
  final bool normalizeLeadingCapitalization;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: hintText,
      textField: true,
      enabled: enabled,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        textInputAction: textInputAction,
        controller: controller,
        enabled: enabled,
        minLines: minLines,
        maxLines: maxLines,
        inputFormatters: [
          if (normalizeLeadingCapitalization)
            const PRFLeadingCapitalizationFormatter(),
        ],
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface,
          height: 1.5,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
          errorText: errorText,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
