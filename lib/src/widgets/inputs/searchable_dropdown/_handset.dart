import 'package:flutter/material.dart';

class PRFSearchableDropdownHandset<T> extends StatelessWidget {
  const PRFSearchableDropdownHandset({
    required this.dropdownMenuEntries,
    required this.onSelected,
    super.key,
    this.width,
    this.initialSelection,
    this.enabled = true,
    this.enableFilter = true,
    this.requestFocusOnTap = true,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
  });

  final double? width;
  final T? initialSelection;
  final bool enabled;
  final bool enableFilter;
  final bool requestFocusOnTap;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final ValueChanged<T?> onSelected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DropdownMenu<T>(
          width: width ?? constraints.maxWidth,
          initialSelection: initialSelection,
          enabled: enabled,
          enableFilter: enableFilter,
          requestFocusOnTap: requestFocusOnTap,
          label: labelText == null ? null : Text(labelText!),
          hintText: hintText,
          helperText: helperText,
          errorText: errorText,
          dropdownMenuEntries: dropdownMenuEntries,
          onSelected: onSelected,
        );
      },
    );
  }
}
