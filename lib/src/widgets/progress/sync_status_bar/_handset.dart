import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/buttons/prf_button.dart';
import 'package:prf_design/src/widgets/progress/sync_status_bar/_shared.dart';

/// Handset layout for PRFSyncStatusBar: text block with full-width actions
/// underneath. Internal — prefer the parent widget.
class PRFSyncStatusBarHandset extends StatelessWidget {
  const PRFSyncStatusBarHandset({required this.data, super.key});

  final SyncStatusData data;

  @override
  Widget build(BuildContext context) {
    final onRetry = data.onRetry;
    final onViewDetails = data.onViewDetails;
    return buildSyncStatusSurface(
      context,
      status: data.status,
      padding: const EdgeInsets.all(PRFSpacingTokens.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildSyncStatusText(context, data: data),
          if (data.hasActions) ...[
            const SizedBox(height: PRFSpacingTokens.md),
            Row(
              children: [
                if (onRetry != null)
                  Expanded(
                    child: PRFButton(
                      onPressed: onRetry,
                      title: data.retryLabel!,
                    ),
                  ),
                if (onRetry != null && onViewDetails != null)
                  const SizedBox(width: PRFSpacingTokens.sm),
                if (onViewDetails != null && onRetry == null)
                  Expanded(
                    child: buildSyncDetailsButton(
                      context,
                      onPressed: onViewDetails,
                      label: data.viewDetailsLabel,
                    ),
                  )
                else if (onViewDetails != null)
                  Flexible(
                    child: buildSyncDetailsButton(
                      context,
                      onPressed: onViewDetails,
                      label: data.viewDetailsLabel,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
