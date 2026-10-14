import 'package:flutter/material.dart';
import 'package:prf_design/src/widgets/inputs/searchable_list/_shared.dart';

/// A selectable search result with a stable [value] and searchable [label].
class PRFSearchableListEntry<T> {
  const PRFSearchableListEntry({required this.value, required this.label});

  /// The underlying value returned through `PRFSearchableList.onSelected`.
  final T value;

  /// Human-readable text used for filtering and display.
  final String label;
}

/// Handset layout for `PRFSearchableList`: full width. Internal — prefer the
/// parent widget.
class PRFSearchableListHandset<T> extends StatelessWidget {
  const PRFSearchableListHandset({
    required this.entries,
    required this.onSelected,
    super.key,
    this.selection,
    this.selections,
    this.hintText = 'Search',
    this.emptyText = 'No results found',
    this.maxResultHeight = 240,
    this.isExpanded = false,
    this.autoFocus = false,
    this.padding,
    this.clearSelectionTooltip = 'Clear selection',
  });

  final List<PRFSearchableListEntry<T>> entries;
  final ValueChanged<T?> onSelected;
  final T? selection;
  final List<T>? selections;
  final String hintText;
  final String emptyText;
  final double maxResultHeight;
  final bool isExpanded;
  final bool autoFocus;
  final EdgeInsetsGeometry? padding;
  final String clearSelectionTooltip;

  @override
  Widget build(BuildContext context) {
    return PRFSearchableListBody<T>(
      entries: entries,
      onSelected: onSelected,
      selection: selection,
      selections: selections,
      hintText: hintText,
      emptyText: emptyText,
      maxResultHeight: maxResultHeight,
      isExpanded: isExpanded,
      autoFocus: autoFocus,
      padding: padding,
      clearSelectionTooltip: clearSelectionTooltip,
    );
  }
}
