import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:prf_design/src/theme/_index.dart';

/// Phone number input backed by `phone_form_field`.
///
/// Renders a text field with the dialling code and an inline country picker.
/// Validates the number as a required, valid mobile number. The selectable
/// countries are configurable via [countries] and default to Kenya.
///
/// Example:
/// ```dart
/// final phoneController = PhoneController();
///
/// PRFPhoneInput(
///   hintText: '0712 345 678',
///   controller: phoneController,
///   onChanged: (number) => _phone = number,
/// )
/// ```
class PRFPhoneInput extends StatelessWidget {
  const PRFPhoneInput({
    required this.hintText,
    required this.controller,
    super.key,
    this.enabled = true,
    this.onChanged,
    this.countries = const [IsoCode.KE],
  });

  /// Placeholder shown while the field is empty.
  final String hintText;

  /// Controller from `phone_form_field`; owns the input value and selection.
  final PhoneController controller;

  /// When false the field is non-interactive.
  final bool enabled;

  /// Invoked with the parsed [PhoneNumber] whenever the value changes.
  final ValueChanged<PhoneNumber>? onChanged;

  /// Countries available in the country selector. Defaults to Kenya.
  final List<IsoCode> countries;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PhoneFormField(
      onChanged: onChanged,
      controller: controller,
      enabled: enabled,
      countrySelectorNavigator: CountrySelectorNavigator.draggableBottomSheet(
        countries: countries,
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
          borderRadius: BorderRadius.circular(PRFRadiusTokens.smd),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.smd),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.smd),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.smd),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: PRFSpacingTokens.lg,
          vertical: PRFSpacingTokens.lg,
        ),
      ),
    );
  }
}
