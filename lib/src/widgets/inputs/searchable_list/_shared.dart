import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/inputs/searchable_list/_handset.dart';

/// Shared stateful body for the searchable list variants. The variants own
/// the outer layout (width, padding); this owns search, selection and results.
/// Internal — prefer `PRFSearchableList`.
class PRFSearchableListBody<T> extends StatefulWidget {
  const PRFSearchableListBody({
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
    this.isTablet = false,
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

  /// Roomier tiles and larger text for tablet layouts.
  final bool isTablet;

  @override
  State<PRFSearchableListBody<T>> createState() =>
      _PRFSearchableListBodyState<T>();
}

class _PRFSearchableListBodyState<T> extends State<PRFSearchableListBody<T>> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  String _query = '';
  bool _hasFocus = false;

  bool get _isMultiSelect => widget.selections != null;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChanged);

    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _focusNode.requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode
      ..removeListener(_onFocusChanged)
      ..dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  List<PRFSearchableListEntry<T>> get _filtered {
    if (_query.isEmpty) return widget.entries;
    final q = _query.toLowerCase();
    return widget.entries
        .where((e) => e.label.toLowerCase().contains(q))
        .toList();
  }

  String? get _selectedLabel {
    if (widget.selection == null) return null;
    for (final entry in widget.entries) {
      if (entry.value == widget.selection) {
        return entry.label;
      }
    }
    return null;
  }

  bool _isItemSelected(T value) {
    if (_isMultiSelect) {
      return widget.selections!.contains(value);
    }
    return value == widget.selection;
  }

  String? _labelForValue(T value) {
    for (final entry in widget.entries) {
      if (entry.value == value) {
        return entry.label;
      }
    }
    return null;
  }

  TextStyle? _itemStyle(ThemeData theme) =>
      widget.isTablet ? theme.textTheme.bodyLarge : theme.textTheme.bodyMedium;

  bool get _showResults => _hasFocus || _query.isNotEmpty || widget.isExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final results = _filtered;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: widget.isExpanded ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (_isMultiSelect)
          _buildMultiSelectChips(theme)
        else if (_selectedLabel != null)
          _buildChip(theme, _selectedLabel!),
        _buildSearchField(theme),
        if (_showResults) ...[
          const SizedBox(height: PRFSpacingTokens.sm),
          _buildResultCount(theme, results.length),
          const SizedBox(height: PRFSpacingTokens.xs),
          _buildResultsList(theme, results),
        ],
      ],
    );

    if (widget.padding != null) {
      return Padding(padding: widget.padding!, child: content);
    }
    return content;
  }

  // --- Single-select chip ---

  Widget _buildChip(ThemeData theme, String label) {
    return Container(
      width: double.infinity,
      // Right padding is tighter: the clear button brings its own 48dp
      // touch area.
      padding: const EdgeInsetsDirectional.only(
        start: PRFSpacingTokens.md,
        end: PRFSpacingTokens.xs,
      ),
      margin: const EdgeInsets.only(bottom: PRFSpacingTokens.sm),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: PRFOpacities.subtle),
        borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: PRFOpacities.glow),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            size: PRFSizeTokens.iconMd,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: PRFSpacingTokens.sm),
          Expanded(
            child: Text(
              label,
              style: _itemStyle(theme)?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            tooltip: widget.clearSelectionTooltip,
            onPressed: () => widget.onSelected(null),
            constraints: const BoxConstraints(
              minWidth: PRFSizeTokens.minTouchTarget,
              minHeight: PRFSizeTokens.minTouchTarget,
            ),
            icon: Icon(
              Icons.close,
              size: PRFSizeTokens.iconMd,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // --- Multi-select chips ---

  Widget _buildMultiSelectChips(ThemeData theme) {
    final selected = widget.selections!;
    if (selected.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: PRFSpacingTokens.sm),
      child: Wrap(
        spacing: PRFSpacingTokens.xs,
        runSpacing: PRFSpacingTokens.xs,
        children: selected.map((value) {
          final label = _labelForValue(value) ?? value.toString();
          return Chip(
            label: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
            backgroundColor: theme.colorScheme.primary.withValues(
              alpha: PRFOpacities.subtle,
            ),
            side: BorderSide(
              color: theme.colorScheme.primary.withValues(
                alpha: PRFOpacities.glow,
              ),
            ),
            deleteButtonTooltipMessage: widget.clearSelectionTooltip,
            deleteIcon: Icon(
              Icons.close,
              size: PRFSizeTokens.iconSm,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            onDeleted: () => widget.onSelected(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSearchField(ThemeData theme) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: (value) {
        setState(() => _query = value);
      },
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        prefixIcon: Icon(
          Icons.search,
          size: PRFSizeTokens.iconMd,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        suffixIcon: _query.isNotEmpty
            ? IconButton(
                tooltip: MaterialLocalizations.of(context).clearButtonTooltip,
                icon: const Icon(Icons.clear, size: PRFSizeTokens.iconMd),
                onPressed: () {
                  _controller.clear();
                  setState(() => _query = '');
                },
              )
            : null,
      ),
    );
  }

  Widget _buildResultCount(ThemeData theme, int count) {
    return Text(
      '$count result${count == 1 ? '' : 's'}',
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildResultsList(
    ThemeData theme,
    List<PRFSearchableListEntry<T>> results,
  ) {
    if (results.isEmpty) {
      final emptyWidget = Container(
        constraints: const BoxConstraints(
          minHeight: PRFSizeTokens.minTouchTarget,
        ),
        alignment: Alignment.center,
        child: Text(
          widget.emptyText,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
      return widget.isExpanded ? Expanded(child: emptyWidget) : emptyWidget;
    }

    final listView = ListView.builder(
      padding: EdgeInsets.zero,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      shrinkWrap: !widget.isExpanded,
      itemCount: results.length,
      itemBuilder: (context, index) {
        final entry = results[index];
        final isSelected = _isItemSelected(entry.value);
        return _buildTile(theme, entry, isSelected);
      },
    );

    if (widget.isExpanded) {
      return Expanded(child: listView);
    }

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: widget.maxResultHeight),
      child: listView,
    );
  }

  Widget _buildTile(
    ThemeData theme,
    PRFSearchableListEntry<T> entry,
    bool isSelected,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PRFSpacingTokens.xs),
      child: Material(
        color: isSelected
            ? theme.colorScheme.primary.withValues(alpha: PRFOpacities.subtle)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
        child: InkWell(
          borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
          onTap: () {
            widget.onSelected(entry.value);
            _controller.clear();
            setState(() => _query = '');
            if (!_isMultiSelect) {
              _focusNode.unfocus();
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: widget.isTablet
                  ? PRFSpacingTokens.lg
                  : PRFSpacingTokens.md,
              vertical: PRFSpacingTokens.md,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
              border: Border.all(
                color: isSelected
                    ? theme.colorScheme.primary.withValues(
                        alpha: PRFOpacities.glow,
                      )
                    : theme.colorScheme.outline.withValues(
                        alpha: PRFOpacities.muted,
                      ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    entry.label,
                    style: _itemStyle(theme)?.copyWith(
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: isSelected ? theme.colorScheme.primary : null,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    size: PRFSizeTokens.iconMd,
                    color: theme.colorScheme.primary,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
