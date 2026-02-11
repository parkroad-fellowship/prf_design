import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design_system/src/widgets/inputs/name/_handset.dart';
import 'package:prf_design_system/src/widgets/inputs/name/_tablet.dart';

class PRFNameInput extends StatelessWidget {
  const PRFNameInput({
    required this.hintText,
    required this.controller,
    super.key,
    this.enabled = true,
  });

  final String hintText;
  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFNameInputTablet(
        hintText: hintText,
        enabled: enabled,
        controller: controller,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFNameInputHandset(
          hintText: hintText,
          enabled: enabled,
          controller: controller,
        ),
        tablet: (_, _) => PRFNameInputTablet(
          hintText: hintText,
          enabled: enabled,
          controller: controller,
        ),
      ),
    );
  }
}
