import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/prf_color_palette.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

class PRFNameInputHandset extends StatelessWidget {
  const PRFNameInputHandset({
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
    final theme = Theme.of(context);

    return Semantics(
      label: hintText,
      textField: true,
      enabled: enabled,
      child: TextFormField(
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        controller: controller,
        enabled: enabled,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          filled: true,
          fillColor: PRFColors.gray50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              PRFRadiusTokens.smd,
            ),
            borderSide: const BorderSide(
              color: PRFColorPalette.navy50,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              PRFRadiusTokens.smd,
            ),
            borderSide: const BorderSide(
              color: PRFColorPalette.navy50,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              PRFRadiusTokens.smd,
            ),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              PRFRadiusTokens.smd,
            ),
            borderSide: BorderSide(
              color: PRFColorPalette.navy50.withValues(
                alpha: .5,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
