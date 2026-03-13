import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

class PRFSearchableListEntry<T> {
  const PRFSearchableListEntry({
    required this.value,
    required this.label,
  });

  final T value;
  final String label;
}

class PRFSearchableListHandset<T> extends StatefulWidget {
  const PRFSearchableListHandset({
    required this.entries,
    required this.onSelected,
    super.key,
    this.selection,
    this.hintText = 'Search',
    this.emptyText = 'No results found',
    this.resultHeight = 200,
  });

  final List<PRFSearchableListEntry<T>> entries;
  final ValueChanged<T?> onSelected;
  final T? selection;
  final String hintText;
  final String emptyText;
  final double resultHeight;

  @override
  State<PRFSearchableListHandset<T>> createState() =>
      _PRFSearchableListHandsetState<T>();
}

class _PRFSearchableListHandsetState<T>
    extends State<PRFSearchableListHandset<T>> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  final GlobalKey _resultsKey = GlobalKey();
  String _query = '';
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode.addListener(_onFocusChanged);
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
    if (_focusNode.hasFocus) {
      _scrollResultsIntoView();
    }
  }

  void _scrollResultsIntoView() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _resultsKey.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        );
      }
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

  bool get _showResults => _hasFocus || _query.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedLabel = _selectedLabel;
    final results = _filtered;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (selectedLabel != null) _buildChip(theme, selectedLabel),
        _buildSearchField(theme),
        if (_showResults) ...[
          const SizedBox(height: PRFSpacingTokens.sm),
          _buildResultCount(theme, results.length),
          const SizedBox(height: PRFSpacingTokens.xs),
          KeyedSubtree(
            key: _resultsKey,
            child: _buildResultsList(theme, results),
          ),
        ],
      ],
    );
  }

  Widget _buildChip(ThemeData theme, String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(PRFSpacingTokens.md),
      margin: const EdgeInsets.only(
        bottom: PRFSpacingTokens.md,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(
          alpha: 0.08,
        ),
        borderRadius: BorderRadius.circular(
          PRFRadiusTokens.md,
        ),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(
            alpha: 0.3,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            size: 20,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: PRFSpacingTokens.sm),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => widget.onSelected(null),
            child: Icon(
              Icons.close,
              size: 18,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(ThemeData theme) {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: (value) {
        setState(() => _query = value);
        _scrollResultsIntoView();
      },
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        prefixIcon: const Icon(Icons.search, size: 20),
        suffixIcon: _query.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, size: 20),
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
      return SizedBox(
        height: 48,
        child: Center(
          child: Text(
            widget.emptyText,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: widget.resultHeight,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: results.length,
        itemBuilder: (context, index) {
          final entry = results[index];
          final isSelected = entry.value == widget.selection;
          return _buildTile(theme, entry, isSelected);
        },
      ),
    );
  }

  Widget _buildTile(
    ThemeData theme,
    PRFSearchableListEntry<T> entry,
    bool isSelected,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: PRFSpacingTokens.xs,
      ),
      child: Material(
        color: isSelected
            ? theme.colorScheme.primary.withValues(
                alpha: 0.08,
              )
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(
          PRFRadiusTokens.md,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(
            PRFRadiusTokens.md,
          ),
          onTap: () {
            widget.onSelected(entry.value);
            _controller.clear();
            setState(() => _query = '');
            _focusNode.unfocus();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: PRFSpacingTokens.md,
              vertical: PRFSpacingTokens.md,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                PRFRadiusTokens.md,
              ),
              border: Border.all(
                color: isSelected
                    ? theme.colorScheme.primary.withValues(
                        alpha: 0.3,
                      )
                    : theme.colorScheme.outline.withValues(
                        alpha: 0.2,
                      ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    entry.label,
                    style: theme.textTheme.bodyMedium?.copyWith(
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
                    size: 20,
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
