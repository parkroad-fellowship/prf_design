import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/inputs/text_area/_handset.dart';
import 'package:prf_design/src/widgets/inputs/text_area/_tablet.dart';

class PRFTextAreaInput extends StatelessWidget {
  const PRFTextAreaInput({
    required this.hintText,
    required this.controller,
    super.key,
    this.enabled = true,
    this.labelText,
    this.errorText,
    this.helperText,
    this.maxLines = 5,
    this.minLines = 3,
    this.textInputAction = TextInputAction.newline,
    this.normalizeLeadingCapitalization = true,
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
  final bool normalizeLeadingCapitalization;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFTextAreaInputTablet(
        hintText: hintText,
        controller: controller,
        maxLines: maxLines,
        minLines: minLines,
        enabled: enabled,
        labelText: labelText,
        errorText: errorText,
        helperText: helperText,
        textInputAction: textInputAction,
        normalizeLeadingCapitalization: normalizeLeadingCapitalization,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFTextAreaInputHandset(
          hintText: hintText,
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          enabled: enabled,
          labelText: labelText,
          errorText: errorText,
          helperText: helperText,
          textInputAction: textInputAction,
          normalizeLeadingCapitalization: normalizeLeadingCapitalization,
        ),
        tablet: (_, _) => PRFTextAreaInputTablet(
          hintText: hintText,
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          enabled: enabled,
          labelText: labelText,
          errorText: errorText,
          helperText: helperText,
          textInputAction: textInputAction,
          normalizeLeadingCapitalization: normalizeLeadingCapitalization,
        ),
      ),
    );
  }
}
