import 'package:flutter/material.dart';

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
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.email_outlined),
        ),
      ),
    );
  }
}
