import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/inputs/form_field_label/_handset.dart';
import 'package:prf_design/src/widgets/inputs/form_field_label/_tablet.dart';

class PRFFormFieldLabel extends StatelessWidget {
  const PRFFormFieldLabel({
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
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFFormFieldLabelTablet(
        label: label,
        isRequired: isRequired,
        color: color,
        isBold: isBold,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFFormFieldLabelHandset(
          label: label,
          isRequired: isRequired,
          color: color,
          isBold: isBold,
        ),
        tablet: (_, _) => PRFFormFieldLabelTablet(
          label: label,
          isRequired: isRequired,
          color: color,
          isBold: isBold,
        ),
      ),
    );
  }
}
