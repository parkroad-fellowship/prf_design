import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

class PRFPasswordInputTablet extends StatelessWidget {
  const PRFPasswordInputTablet({
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
    final theme = Theme.of(context);

    return ValueListenableBuilder<bool>(
      valueListenable: hidePasswordNotifier,
      builder: (context, hidePassword, child) => TextFormField(
        controller: passwordController,
        enabled: enabled,
        obscureText: hidePassword,
        keyboardType: TextInputType.visiblePassword,
        style: theme.textTheme.titleMedium,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          prefixIcon: const Icon(
            Icons.lock_outline,
            size: 28,
          ),
          suffixIcon: Semantics(
            label: 'Toggle password visibility',
            child: IconButton(
              onPressed: () {
                hidePasswordNotifier.value = !hidePassword;
              },
              icon: Icon(
                hidePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 28,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: PRFSpacingTokens.xl,
            vertical: PRFSpacingTokens.xxl,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
        ),
        semanticsLabel: hintText,
      ),
    );
  }
}
