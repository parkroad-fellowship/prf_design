import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/buttons/prf_button.dart';
import 'package:prf_design/src/widgets/progress/sync_status_bar/_shared.dart';

/// Tablet layout for PRFSyncStatusBar: text block with actions at the
/// trailing edge. Internal — prefer the parent widget.
class PRFSyncStatusBarTablet extends StatelessWidget {
  const PRFSyncStatusBarTablet({required this.data, super.key});

  /// Width of the trailing action column.
  static const double _actionsWidth = 240;

  final SyncStatusData data;

  @override
  Widget build(BuildContext context) {
    final onRetry = data.onRetry;
    final onViewDetails = data.onViewDetails;
    return buildSyncStatusSurface(
      context,
      status: data.status,
      padding: const EdgeInsets.all(PRFSpacingTokens.xl),
      child: Row(
        children: [
          Expanded(child: buildSyncStatusText(context, data: data)),
          if (data.hasActions) ...[
            const SizedBox(width: PRFSpacingTokens.xl),
            SizedBox(
              width: _actionsWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onRetry != null)
                    PRFButton(onPressed: onRetry, title: data.retryLabel!),
                  if (onRetry != null && onViewDetails != null)
                    const SizedBox(height: PRFSpacingTokens.sm),
                  if (onViewDetails != null)
                    buildSyncDetailsButton(
                      context,
                      onPressed: onViewDetails,
                      label: data.viewDetailsLabel,
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
