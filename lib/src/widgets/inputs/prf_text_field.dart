import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/widgets/inputs/_text_field_base.dart';

/// Input variants supported by [PRFTextField].
enum PRFTextFieldType {
  /// Plain single-line text.
  text,

  /// Email address: email keyboard, prefix envelope icon.
  email,

  /// Person name: word capitalization.
  name,

  /// Numeric: digits-only, optional unit/currency prefix.
  number,

  /// Password: obscured, with a visibility toggle.
  password,

  /// Multi-line text area (use with [PRFTextField.minLines] and
  /// [PRFTextField.maxLines]).
  textArea,
}

/// Single adaptive text input implementation for every PRF input variant.
///
/// Pick a behaviour with [type]: text, email, name, number (digits-only with
/// an optional [prefixText] unit), password (obscured with a visibility
/// toggle), or a multi-line text area.
///
/// Example:
/// ```dart
/// PRFTextField(
///   hintText: 'Enter amount',
///   controller: _amountController,
///   type: PRFTextFieldType.number,
///   prefixText: 'KES',
///   errorText: _amountError,
/// )
/// ```
class PRFTextField extends StatelessWidget {
  const PRFTextField({
    required this.hintText,
    required this.controller,
    this.type = PRFTextFieldType.text,
    this.enabled = true,
    this.readOnly = false,
    this.onChanged,
    this.labelText,
    this.errorText,
    this.helperText,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.normalizeLeadingCapitalization = true,
    this.isLoading = false,
    this.prefixText,
    this.minLines,
    this.maxLines,
    this.autocorrect,
    this.obscureNotifier,
    this.initiallyHidden = true,
    super.key,
  });

  /// Placeholder shown while the field is empty.
  final String hintText;

  /// The editing controller; owns the input value and selection.
  final TextEditingController controller;

  /// Behaviour of the field: keyboard, formatters, icons and visibility.
  /// Defaults to [PRFTextFieldType.text].
  final PRFTextFieldType type;

  /// When false the field is non-interactive.
  final bool enabled;

  /// When true the field shows the value but cannot be edited.
  final bool readOnly;

  /// Invoked with the new value whenever the text changes.
  final ValueChanged<String>? onChanged;

  /// Floating label shown above the field.
  final String? labelText;

  /// Error message shown below the field; also turns the border red.
  final String? errorText;

  /// Helper text shown below the field when there is no error.
  final String? helperText;

  /// Overrides the keyboard inferred from [type].
  final TextInputType? keyboardType;

  /// Action shown on the soft keyboard. Defaults to
  /// [TextInputAction.next] to move focus to the next field.
  final TextInputAction textInputAction;

  /// When true, the first letter of each word is capitalized for
  /// [PRFTextFieldType.name] and sentences for [PRFTextFieldType.textArea].
  final bool normalizeLeadingCapitalization;

  /// When true the field is visually disabled while a value is loading.
  final bool isLoading;

  /// Optional unit/currency prefix shown for [PRFTextFieldType.number] inputs.
  final String? prefixText;

  /// Minimum visible lines (multi-line types).
  final int? minLines;

  /// Maximum visible lines (multi-line types); defaults to 1 for single-line.
  final int? maxLines;

  /// Overrides autocorrect; defaults to `true`.
  final bool? autocorrect;

  /// Optional external visibility control for password inputs.
  final ValueNotifier<bool>? obscureNotifier;

  /// Initial obscured state for password inputs without an external notifier.
  final bool initiallyHidden;

  @override
  Widget build(BuildContext context) {
    final base = PRFTextFieldBase(
      hintText: hintText,
      controller: controller,
      type: type,
      enabled: enabled,
      readOnly: readOnly,
      onChanged: onChanged,
      labelText: labelText,
      errorText: errorText,
      helperText: helperText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      normalizeLeadingCapitalization: normalizeLeadingCapitalization,
      isLoading: isLoading,
      prefixText: prefixText,
      minLines: minLines,
      maxLines: maxLines,
      autocorrect: autocorrect,
      obscureNotifier: obscureNotifier,
      initiallyHidden: initiallyHidden,
    );
    return PRFAdaptive(
      handset: (_) => base,
      tablet: (_) => base,
      builder: (_, _) => base,
    );
  }
}
