import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/dialogs/media_source_sheet/_shared.dart';
import 'package:prf_design/src/widgets/dialogs/media_source_sheet/media_source_sheet.dart';

/// Handset layout for PRFMediaSourceSheet: full-width stacked rows.
/// Internal — prefer the parent widget.
class PRFMediaSourceSheetHandset extends StatelessWidget {
  const PRFMediaSourceSheetHandset({
    required this.options,
    required this.onSelected,
    super.key,
  });

  final List<MediaSourceOption> options;
  final ValueChanged<PRFMediaSource> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(PRFSpacingTokens.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < options.length; i++) ...[
              if (i > 0) const SizedBox(height: PRFSpacingTokens.md),
              buildMediaSourceSurface(
                context,
                option: options[i],
                onTap: () => onSelected(options[i].source),
                padding: const EdgeInsets.all(PRFSpacingTokens.md),
                child: Row(
                  children: [
                    buildMediaSourceIcon(
                      context,
                      icon: options[i].icon,
                      iconSize: PRFSizeTokens.iconLg,
                    ),
                    const SizedBox(width: PRFSpacingTokens.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildMediaSourceLabel(
                            context,
                            label: options[i].label,
                          ),
                          const SizedBox(height: PRFSpacingTokens.xs),
                          buildMediaSourceDescription(
                            context,
                            description: options[i].description,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: PRFSpacingTokens.sm),
                    Icon(
                      Icons.chevron_right,
                      size: PRFSizeTokens.iconLg,
                      color: scheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
