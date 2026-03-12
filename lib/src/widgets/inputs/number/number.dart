import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/inputs/number/_handset.dart';
import 'package:prf_design/src/widgets/inputs/number/_tablet.dart';

class PRFNumberInput extends StatelessWidget {
  const PRFNumberInput({
    required this.hintText,
    required this.controller,
    super.key,
    this.isLoading = false,
    this.enabled = true,
    this.prefixText,
    this.labelText,
    this.errorText,
    this.helperText,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isLoading;
  final bool enabled;
  final String? prefixText;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final ValueChanged<String>? onChanged;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFNumberInputTablet(
        hintText: hintText,
        controller: controller,
        isLoading: isLoading,
        enabled: enabled,
        prefixText: prefixText,
        labelText: labelText,
        errorText: errorText,
        helperText: helperText,
        onChanged: onChanged,
        textInputAction: textInputAction,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFNumberInputHandset(
          hintText: hintText,
          controller: controller,
          isLoading: isLoading,
          enabled: enabled,
          prefixText: prefixText,
          labelText: labelText,
          errorText: errorText,
          helperText: helperText,
          onChanged: onChanged,
          textInputAction: textInputAction,
        ),
        tablet: (_, _) => PRFNumberInputTablet(
          hintText: hintText,
          controller: controller,
          isLoading: isLoading,
          enabled: enabled,
          prefixText: prefixText,
          labelText: labelText,
          errorText: errorText,
          helperText: helperText,
          onChanged: onChanged,
          textInputAction: textInputAction,
        ),
      ),
    );
  }
}
