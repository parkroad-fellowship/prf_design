import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/inputs/searchable_dropdown/_handset.dart';
import 'package:prf_design/src/widgets/inputs/searchable_dropdown/_tablet.dart';

class PRFSearchableDropdown<T> extends StatelessWidget {
  const PRFSearchableDropdown({
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
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFSearchableDropdownTablet<T>(
        width: width,
        initialSelection: initialSelection,
        enabled: enabled,
        enableFilter: enableFilter,
        requestFocusOnTap: requestFocusOnTap,
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        dropdownMenuEntries: dropdownMenuEntries,
        onSelected: onSelected,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFSearchableDropdownHandset<T>(
          width: width,
          initialSelection: initialSelection,
          enabled: enabled,
          enableFilter: enableFilter,
          requestFocusOnTap: requestFocusOnTap,
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
          errorText: errorText,
          dropdownMenuEntries: dropdownMenuEntries,
          onSelected: onSelected,
        ),
        tablet: (_, _) => PRFSearchableDropdownTablet<T>(
          width: width,
          initialSelection: initialSelection,
          enabled: enabled,
          enableFilter: enableFilter,
          requestFocusOnTap: requestFocusOnTap,
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
          errorText: errorText,
          dropdownMenuEntries: dropdownMenuEntries,
          onSelected: onSelected,
        ),
      ),
    );
  }
}
