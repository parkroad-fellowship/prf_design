import 'package:flutter/material.dart';
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

    return TextFormField(
      controller: emailController,
      enabled: enabled,
      keyboardType: TextInputType.emailAddress,
      style: theme.textTheme.titleMedium,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        prefixIcon: const Icon(
          Icons.email_outlined,
          size: 28,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 24,
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
    );
  }
}
