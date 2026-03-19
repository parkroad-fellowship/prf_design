import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:prf_design/src/widgets/inputs/phone/_handset.dart';

class PRFPhoneInput extends StatelessWidget {
  const PRFPhoneInput({
    required this.hintText,
    required this.controller,
    super.key,
    this.enabled = true,
    this.onChanged,
  });

  final String hintText;
  final PhoneController controller;
  final bool enabled;
  final ValueChanged<PhoneNumber>? onChanged;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFPhoneInputHandset(
        hintText: hintText,
        controller: controller,
        enabled: enabled,
        onChanged: onChanged,
      ),
    );
  }
}
