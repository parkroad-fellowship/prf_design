import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/dialogs/media_source_sheet/_shared.dart';
import 'package:prf_design/src/widgets/dialogs/media_source_sheet/media_source_sheet.dart';

/// Tablet layout for PRFMediaSourceSheet: side-by-side option cards.
/// Internal — prefer the parent widget.
class PRFMediaSourceSheetTablet extends StatelessWidget {
  const PRFMediaSourceSheetTablet({
    required this.options,
    required this.onSelected,
    super.key,
  });

  final List<MediaSourceOption> options;
  final ValueChanged<PRFMediaSource> onSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(PRFSpacingTokens.xl),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < options.length; i++) ...[
                if (i > 0) const SizedBox(width: PRFSpacingTokens.lg),
                Expanded(
                  child: buildMediaSourceSurface(
                    context,
                    option: options[i],
                    onTap: () => onSelected(options[i].source),
                    padding: const EdgeInsets.all(PRFSpacingTokens.xl),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildMediaSourceIcon(
                          context,
                          icon: options[i].icon,
                          iconSize: PRFSizeTokens.iconXl,
                        ),
                        const SizedBox(height: PRFSpacingTokens.md),
                        buildMediaSourceLabel(
                          context,
                          label: options[i].label,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: PRFSpacingTokens.xs),
                        buildMediaSourceDescription(
                          context,
                          description: options[i].description,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
