import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PRFNumberInputHandset extends StatelessWidget {
  const PRFNumberInputHandset({
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
    final theme = Theme.of(context);

    return TextFormField(
      textInputAction: textInputAction,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(hintText: hintText, prefixText: prefixText),
      style: theme.textTheme.bodyMedium,
      controller: controller,
      enabled: !isLoading,
    );
  }
}
