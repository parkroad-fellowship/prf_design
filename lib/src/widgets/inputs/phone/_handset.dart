import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PRFPhoneInputHandset extends StatelessWidget {
  const PRFPhoneInputHandset({
    required this.hintText,
    required this.controller,
    super.key,
    this.enabled = true,
    this.onChanged,
  });

  final String hintText;
  final PhoneController controller;
  final bool enabled;
  final ValueChanged<PhoneNumber>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PhoneFormField(
      onChanged: onChanged,
      controller: controller,
      enabled: enabled,
      countrySelectorNavigator:
          const CountrySelectorNavigator.draggableBottomSheet(
            countries: [IsoCode.KE],
          ),
      validator: PhoneValidator.compose([
        PhoneValidator.required(context),
        PhoneValidator.validMobile(context),
      ]),
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        filled: true,
        fillColor: theme.colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: .2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: .2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: .1),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
