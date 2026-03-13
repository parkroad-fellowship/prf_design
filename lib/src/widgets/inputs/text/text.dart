import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/inputs/text/_handset.dart';
import 'package:prf_design/src/widgets/inputs/text/_tablet.dart';

class PRFTextInput extends StatelessWidget {
  const PRFTextInput({
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
    this.normalizeLeadingCapitalization = true,
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
  final bool normalizeLeadingCapitalization;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFTextInputTablet(
        hintText: hintText,
        controller: controller,
        enabled: enabled,
        readOnly: readOnly,
        onChanged: onChanged,
        labelText: labelText,
        errorText: errorText,
        helperText: helperText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        normalizeLeadingCapitalization: normalizeLeadingCapitalization,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFTextInputHandset(
          hintText: hintText,
          controller: controller,
          enabled: enabled,
          readOnly: readOnly,
          onChanged: onChanged,
          labelText: labelText,
          errorText: errorText,
          helperText: helperText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          normalizeLeadingCapitalization: normalizeLeadingCapitalization,
        ),
        tablet: (_, _) => PRFTextInputTablet(
          hintText: hintText,
          controller: controller,
          enabled: enabled,
          readOnly: readOnly,
          onChanged: onChanged,
          labelText: labelText,
          errorText: errorText,
          helperText: helperText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          normalizeLeadingCapitalization: normalizeLeadingCapitalization,
        ),
      ),
    );
  }
}
