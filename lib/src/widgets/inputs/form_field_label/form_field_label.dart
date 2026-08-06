import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/widgets/inputs/form_field_label/_handset.dart';
import 'package:prf_design/src/widgets/inputs/form_field_label/_tablet.dart';

/// Label for a form field, with an optional required marker.
///
/// Renders [label] with a subtle `*` indicator when [isRequired] is true. Used
/// internally by `PRFFormSection` but also exported for standalone use.
///
/// Example:
/// ```dart
/// PRFFormFieldLabel(
///   label: 'Phone number',
///   isRequired: true,
/// )
/// ```
class PRFFormFieldLabel extends StatelessWidget {
  const PRFFormFieldLabel({
    required this.label,
    super.key,
    this.isRequired,
    this.color,
    this.isBold,
  });

  /// Label text.
  final String label;

  /// When true a required marker is appended; defaults to false.
  final bool? isRequired;

  /// Overrides the default label colour.
  final Color? color;

  /// When true the label uses the bold text style.
  final bool? isBold;

  @override
  Widget build(BuildContext context) {
    return PRFAdaptive(
      handset: (_) => PRFFormFieldLabelHandset(
        label: label,
        isRequired: isRequired,
        color: color,
        isBold: isBold,
      ),
      tablet: (_) => PRFFormFieldLabelTablet(
        label: label,
        isRequired: isRequired,
        color: color,
        isBold: isBold,
      ),
      builder: (_, _) => PRFFormFieldLabelTablet(
        label: label,
        isRequired: isRequired,
        color: color,
        isBold: isBold,
      ),
    );
  }
}
