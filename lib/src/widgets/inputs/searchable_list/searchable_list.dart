import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/inputs/searchable_list/_handset.dart';

export '_handset.dart' show PRFSearchableListEntry;

class PRFSearchableList<T> extends StatelessWidget {
  const PRFSearchableList({
    required this.entries,
    required this.onSelected,
    super.key,
    this.selection,
    this.selections,
    this.hintText = 'Search',
    this.emptyText = 'No results found',
    this.resultHeight = 200,
  });

  final List<PRFSearchableListEntry<T>> entries;
  final ValueChanged<T?> onSelected;

  /// Single-select: currently selected value. Mutually exclusive with
  /// [selections].
  final T? selection;

  /// Multi-select: currently selected values. When non-null the widget renders
  /// in multi-select mode — showing chips for every selected value and allowing
  /// multiple items to be picked. Mutually exclusive with [selection].
  final List<T>? selections;

  final String hintText;
  final String emptyText;
  final double resultHeight;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFSearchableListHandset<T>(
        entries: entries,
        onSelected: onSelected,
        selection: selection,
        selections: selections,
        hintText: hintText,
        emptyText: emptyText,
        resultHeight: resultHeight,
      ),
    );
  }
}
