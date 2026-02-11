import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design_system/src/widgets/inputs/number/_handset.dart';
import 'package:prf_design_system/src/widgets/inputs/number/_tablet.dart';

class PRFNumberInput extends StatelessWidget {
  const PRFNumberInput({
    required this.hintText,
    required this.controller,
    super.key,
    this.isLoading = false,
    this.prefixText,
    this.textInputAction = TextInputAction.next,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isLoading;
  final String? prefixText;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFNumberInputTablet(
        hintText: hintText,
        controller: controller,
        isLoading: isLoading,
        prefixText: prefixText,
        textInputAction: textInputAction,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFNumberInputHandset(
          hintText: hintText,
          controller: controller,
          isLoading: isLoading,
          prefixText: prefixText,
          textInputAction: textInputAction,
        ),
        tablet: (_, _) => PRFNumberInputTablet(
          hintText: hintText,
          controller: controller,
          isLoading: isLoading,
          prefixText: prefixText,
          textInputAction: textInputAction,
        ),
      ),
    );
  }
}
