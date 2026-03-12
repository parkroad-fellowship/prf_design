import 'package:flutter/material.dart';

class PRFTextInputHandset extends StatelessWidget {
  const PRFTextInputHandset({
    required this.hintText,
    required this.controller,
    super.key,
    this.enabled = true,
    this.readOnly = false,
    this.onChanged,
    this.labelText,
    this.errorText,
    this.helperText,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
  });

  final String hintText;
  final TextEditingController controller;
  final bool enabled;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: hintText,
      textField: true,
      enabled: enabled,
      child: TextFormField(
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: textInputAction,
        controller: controller,
        enabled: enabled,
        readOnly: readOnly,
        onChanged: onChanged,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
          errorText: errorText,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
