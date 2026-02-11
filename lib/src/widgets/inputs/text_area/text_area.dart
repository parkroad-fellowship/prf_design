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
    this.maxLines = 5,
    this.minLines = 3,
    this.textInputAction = TextInputAction.newline,
  });

  final String hintText;
  final TextEditingController controller;
  final bool enabled;
  final int minLines;
  final int maxLines;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFTextAreaInputTablet(
        hintText: hintText,
        controller: controller,
        maxLines: maxLines,
        minLines: minLines,
        enabled: enabled,
        textInputAction: textInputAction,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFTextAreaInputHandset(
          hintText: hintText,
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          enabled: enabled,
          textInputAction: textInputAction,
        ),
        tablet: (_, _) => PRFTextAreaInputTablet(
          hintText: hintText,
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          enabled: enabled,
          textInputAction: textInputAction,
        ),
      ),
    );
  }
}
