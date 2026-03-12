import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PRFNumberInputTablet extends StatelessWidget {
  const PRFNumberInputTablet({
    required this.hintText,
    required this.controller,
    super.key,
    this.isLoading = false,
    this.enabled = true,
    this.prefixText,
    this.labelText,
    this.errorText,
    this.helperText,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isLoading;
  final bool enabled;
  final String? prefixText;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final ValueChanged<String>? onChanged;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: hintText,
      textField: true,
      enabled: enabled && !isLoading,
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.number,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixText: prefixText,
          helperText: helperText,
          errorText: errorText,
          hintStyle: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        style: theme.textTheme.titleMedium,
        controller: controller,
        enabled: enabled && !isLoading,
        onChanged: onChanged,
      ),
    );
  }
}
