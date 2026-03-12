import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/prf_color_palette.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

class PRFEmailInputTablet extends StatelessWidget {
  const PRFEmailInputTablet({
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
    final theme = Theme.of(context);

    return Semantics(
      label: hintText,
      textField: true,
      enabled: enabled,
      child: TextFormField(
        controller: emailController,
        enabled: enabled,
        keyboardType: TextInputType.emailAddress,
        style: theme.textTheme.titleMedium,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          filled: true,
          fillColor: PRFColors.gray50,
          prefixIcon: const Icon(
            Icons.email_outlined,
            size: 28,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: PRFSpacingTokens.xl,
            vertical: PRFSpacingTokens.xxl,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              PRFRadiusTokens.lg,
            ),
            borderSide: const BorderSide(
              color: PRFColorPalette.navy50,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              PRFRadiusTokens.lg,
            ),
            borderSide: const BorderSide(
              color: PRFColorPalette.navy50,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              PRFRadiusTokens.lg,
            ),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
