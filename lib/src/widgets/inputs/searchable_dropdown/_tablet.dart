import 'package:flutter/material.dart';

class PRFSearchableDropdownTablet<T> extends StatefulWidget {
  const PRFSearchableDropdownTablet({
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
  State<PRFSearchableDropdownTablet<T>> createState() =>
      _PRFSearchableDropdownTabletState<T>();
}

class _PRFSearchableDropdownTabletState<T>
    extends State<PRFSearchableDropdownTablet<T>> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: _labelForValue(widget.initialSelection),
    );
  }

  @override
  void didUpdateWidget(covariant PRFSearchableDropdownTablet<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialSelection != widget.initialSelection ||
        oldWidget.dropdownMenuEntries != widget.dropdownMenuEntries) {
      final label = _labelForValue(widget.initialSelection);
      if (_controller.text != label) {
        _controller.text = label;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _labelForValue(T? value) {
    if (value == null) return '';
    for (final entry in widget.dropdownMenuEntries) {
      if (entry.value == value) {
        return entry.label;
      }
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DropdownMenu<T>(
          width: widget.width ?? constraints.maxWidth,
          initialSelection: widget.initialSelection,
          enabled: widget.enabled,
          enableFilter: widget.enableFilter,
          requestFocusOnTap: widget.requestFocusOnTap,
          controller: _controller,
          label: widget.labelText == null ? null : Text(widget.labelText!),
          hintText: widget.hintText,
          helperText: widget.helperText,
          errorText: widget.errorText,
          dropdownMenuEntries: widget.dropdownMenuEntries,
          onSelected: (value) {
            _controller.text = _labelForValue(value);
            widget.onSelected(value);
          },
        );
      },
    );
  }
}
