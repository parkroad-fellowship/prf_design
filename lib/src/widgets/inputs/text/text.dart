import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design_system/src/widgets/inputs/text/_handset.dart';
import 'package:prf_design_system/src/widgets/inputs/text/_tablet.dart';

class PRFTextInput extends StatelessWidget {
  const PRFTextInput({
    required this.hintText,
    required this.controller,
    super.key,
    this.enabled = true,
    this.onChanged,
  });

  final String hintText;
  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFTextInputTablet(
        hintText: hintText,
        controller: controller,
        enabled: enabled,
        onChanged: onChanged,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFTextInputHandset(
          hintText: hintText,
          controller: controller,
          enabled: enabled,
          onChanged: onChanged,
        ),
        tablet: (_, _) => PRFTextInputTablet(
          hintText: hintText,
          controller: controller,
          enabled: enabled,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
