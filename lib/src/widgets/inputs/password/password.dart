import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design_system/src/widgets/inputs/password/_handset.dart';
import 'package:prf_design_system/src/widgets/inputs/password/_tablet.dart';

class PRFPasswordInput extends StatelessWidget {
  const PRFPasswordInput({
    required this.hintText,
    required this.hidePasswordNotifier,
    required this.passwordController,
    super.key,
    this.enabled = true,
  });

  final String hintText;
  final ValueNotifier<bool> hidePasswordNotifier;
  final TextEditingController passwordController;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFPasswordInputTablet(
        hintText: hintText,
        hidePasswordNotifier: hidePasswordNotifier,
        passwordController: passwordController,
        enabled: enabled,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFPasswordInputHandset(
          hintText: hintText,
          hidePasswordNotifier: hidePasswordNotifier,
          passwordController: passwordController,
          enabled: enabled,
        ),
        tablet: (_, _) => PRFPasswordInputTablet(
          hintText: hintText,
          hidePasswordNotifier: hidePasswordNotifier,
          passwordController: passwordController,
          enabled: enabled,
        ),
      ),
    );
  }
}
