import 'package:flutter/material.dart';
import 'package:prf_design/src/widgets/inputs/form_field_label/_shared.dart';

/// Handset layout for PRFFormFieldLabel. Internal — prefer the parent widget.
class PRFFormFieldLabelHandset extends StatelessWidget {
  const PRFFormFieldLabelHandset({
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
  Widget build(BuildContext context) => buildFormFieldLabel(
    context,
    label: label,
    isRequired: isRequired,
    color: color,
  );
}
