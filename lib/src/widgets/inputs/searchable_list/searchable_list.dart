import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/buttons/prf_button.dart';
import 'package:prf_design/src/widgets/dialogs/bottom_sheet.dart';
import 'package:prf_design/src/widgets/inputs/searchable_list/_handset.dart';

export '_handset.dart' show PRFSearchableListEntry;

/// Searchable picker list with single- and multi-select modes.
///
/// Wraps a search field above a list of filtered [entries]. Passing
/// [selections] switches to multi-select mode, which renders selected values as
/// removable chips. Single-select is enabled by passing [selection] instead.
///
/// Works inline on normal pages and modally in bottom sheets (`showModal`).
///
/// Example (single select):
/// ```dart
/// PRFSearchableList<Team>(
///   entries: teams
///       .map((t) => PRFSearchableListEntry(value: t, label: t.name))
///       .toList(),
///   onSelected: (team) => setState(() => _team = team),
///   selection: _team,
/// )
/// ```
///
/// Example (modal bottom sheet picker):
/// ```dart
/// final team = await PRFSearchableList.showModal<Team>(
///   context,
///   title: 'Select team',
///   entries: teams
///       .map((t) => PRFSearchableListEntry(value: t, label: t.name))
///       .toList(),
///   selection: _team,
/// );
/// ```
class PRFSearchableList<T> extends StatelessWidget {
  const PRFSearchableList({
    required this.entries,
    required this.onSelected,
    super.key,
    this.selection,
    this.selections,
    this.hintText = 'Search',
    this.emptyText = 'No results found',
    this.maxResultHeight = 240,
    this.resultHeight,
    this.isExpanded = false,
    this.autoFocus = false,
    this.padding,
  });

  /// The items available to pick from.
  final List<PRFSearchableListEntry<T>> entries;

  /// Invoked with the picked value — or `null` when a single selection is
  /// cleared. In multi-select mode called with the toggled value.
  final ValueChanged<T?> onSelected;

  /// Single-select: currently selected value. Mutually exclusive with
  /// [selections].
  final T? selection;

  /// Multi-select: currently selected values. When non-null the widget renders
  /// in multi-select mode — showing chips for every selected value and allowing
  /// multiple items to be picked. Mutually exclusive with [selection].
  final List<T>? selections;

  /// Placeholder of the search field. Defaults to `Search`.
  final String hintText;

  /// Message shown when no entry matches the query. Defaults to
  /// `No results found`.
  final String emptyText;

  /// Maximum height of the results dropdown when inline. Defaults to 240.
  final double maxResultHeight;

  /// Deprecated result height override for backwards compatibility.
  final double? resultHeight;

  /// Effective max result height considering deprecated `resultHeight`.
  double get effectiveMaxResultHeight => resultHeight ?? maxResultHeight;

  /// When true, the results list expands to fill available vertical space
  /// (`Expanded`). Ideal when used inside a bottom sheet or flex container.
  /// Defaults to false.
  final bool isExpanded;

  /// Automatically focuses the search field when rendered. Defaults to false.
  final bool autoFocus;

  /// Optional padding around the searchable list container.
  final EdgeInsetsGeometry? padding;

  /// Presents a searchable picker modally inside a [PRFBottomSheet].
  ///
  /// Automatically resolves with the chosen item in single-select mode when an
  /// entry is tapped. In multi-select mode, a "Done" button allows the user to
  /// complete selection.
  static Future<T?> showModal<T>(
    BuildContext context, {
    required String title,
    required List<PRFSearchableListEntry<T>> entries,
    T? selection,
    List<T>? selections,
    ValueChanged<T?>? onSelected,
    String hintText = 'Search',
    String emptyText = 'No results found',
    bool showHandle = true,
    double heightFactor = 0.9,
    bool autoFocus = true,
    String doneButtonText = 'Done',
  }) {
    final isMultiSelect = selections != null;

    return PRFBottomSheet.show<T>(
      context,
      title: title,
      showHandle: showHandle,
      heightFactor: heightFactor,
      child: _PRFSearchableListModalBody<T>(
        entries: entries,
        selection: selection,
        selections: selections,
        onSelected: onSelected,
        hintText: hintText,
        emptyText: emptyText,
        autoFocus: autoFocus,
        isMultiSelect: isMultiSelect,
        doneButtonText: doneButtonText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PRFAdaptive(
      handset: (_) => PRFSearchableListHandset<T>(
        entries: entries,
        onSelected: onSelected,
        selection: selection,
        selections: selections,
        hintText: hintText,
        emptyText: emptyText,
        maxResultHeight: effectiveMaxResultHeight,
        isExpanded: isExpanded,
        autoFocus: autoFocus,
        padding: padding,
      ),
      builder: (_, _) => PRFSearchableListHandset<T>(
        entries: entries,
        onSelected: onSelected,
        selection: selection,
        selections: selections,
        hintText: hintText,
        emptyText: emptyText,
        maxResultHeight: effectiveMaxResultHeight,
        isExpanded: isExpanded,
        autoFocus: autoFocus,
        padding: padding,
      ),
    );
  }
}

class _PRFSearchableListModalBody<T> extends StatefulWidget {
  const _PRFSearchableListModalBody({
    required this.entries,
    required this.hintText,
    required this.emptyText,
    required this.autoFocus,
    required this.isMultiSelect,
    required this.doneButtonText,
    this.selection,
    this.selections,
    this.onSelected,
  });

  final List<PRFSearchableListEntry<T>> entries;
  final T? selection;
  final List<T>? selections;
  final ValueChanged<T?>? onSelected;
  final String hintText;
  final String emptyText;
  final bool autoFocus;
  final bool isMultiSelect;
  final String doneButtonText;

  @override
  State<_PRFSearchableListModalBody<T>> createState() =>
      __PRFSearchableListModalBodyState<T>();
}

class __PRFSearchableListModalBodyState<T>
    extends State<_PRFSearchableListModalBody<T>> {
  late T? _selection;
  late List<T>? _selections;

  @override
  void initState() {
    super.initState();
    _selection = widget.selection;
    _selections = widget.selections != null
        ? List<T>.from(widget.selections!)
        : null;
  }

  void _handleSelected(T? value) {
    if (widget.isMultiSelect) {
      setState(() {
        if (value != null) {
          if (_selections!.contains(value)) {
            _selections!.remove(value);
          } else {
            _selections!.add(value);
          }
        }
      });
      widget.onSelected?.call(value);
    } else {
      setState(() => _selection = value);
      widget.onSelected?.call(value);
      if (value != null) {
        Navigator.pop(context, value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        PRFSpacingTokens.lg,
        PRFSpacingTokens.md,
        PRFSpacingTokens.lg,
        PRFSpacingTokens.lg,
      ),
      child: Column(
        children: [
          Expanded(
            child: PRFSearchableList<T>(
              entries: widget.entries,
              selection: _selection,
              selections: _selections,
              onSelected: _handleSelected,
              hintText: widget.hintText,
              emptyText: widget.emptyText,
              autoFocus: widget.autoFocus,
              isExpanded: true,
            ),
          ),
          if (widget.isMultiSelect) ...[
            const SizedBox(height: PRFSpacingTokens.md),
            PRFButton(
              title: widget.doneButtonText,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ],
      ),
    );
  }
}
