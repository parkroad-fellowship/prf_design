import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/inputs/email_address/_handset.dart';
import 'package:prf_design/src/widgets/inputs/email_address/_tablet.dart';

class PRFEmailInput extends StatelessWidget {
  const PRFEmailInput({
    required this.hintText,
    required this.emailController,
    super.key,
    this.enabled = true,
  });

  final String hintText;
  final TextEditingController emailController;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFEmailInputTablet(
        hintText: hintText,
        emailController: emailController,
        enabled: enabled,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFEmailInputHandset(
          hintText: hintText,
          emailController: emailController,
          enabled: enabled,
        ),
        tablet: (_, _) => PRFEmailInputTablet(
          hintText: hintText,
          emailController: emailController,
          enabled: enabled,
        ),
      ),
    );
  }
}
