import 'package:flutter/material.dart';

class PRFTextAreaInputTablet extends StatelessWidget {
  const PRFTextAreaInputTablet({
    required this.hintText,
    required this.controller,
    super.key,
    this.enabled = true,
    this.labelText,
    this.errorText,
    this.helperText,
    this.maxLines = 6,
    this.minLines = 4,
    this.textInputAction = TextInputAction.newline,
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
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.onSurface,
          height: 1.5,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
          errorText: errorText,
          hintStyle: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
