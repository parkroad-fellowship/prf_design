// Shared data and pure builders for PRFSyncStatusBar variants.
import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/extensions/theme_context_extensions.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/progress/sync_status_bar/sync_status_bar.dart';

/// Fully resolved text and callbacks for one render of the bar.
@immutable
class SyncStatusData {
  const SyncStatusData({
    required this.status,
    required this.title,
    required this.viewDetailsLabel,
    this.description,
    this.progress,
    this.currentItemLabel,
    this.onRetry,
    this.retryLabel,
    this.onViewDetails,
  });

  final PRFSyncStatus status;
  final String title;
  final String? description;
  final double? progress;
  final String? currentItemLabel;

  /// Null when no retry button should show for this state.
  final VoidCallback? onRetry;
  final String? retryLabel;
  final VoidCallback? onViewDetails;
  final String viewDetailsLabel;

  bool get isSyncing => status == PRFSyncStatus.syncing;
  bool get hasActions => onRetry != null || onViewDetails != null;
}

String _items(int count) => count == 1 ? '1 item' : '$count items';

SyncStatusData resolveSyncStatus({
  required PRFSyncStatus status,
  required int count,
  required String viewDetailsLabel,
  double? progress,
  String? currentItemLabel,
  String? title,
  String? description,
  VoidCallback? onRetry,
  String? retryLabel,
  VoidCallback? onViewDetails,
}) {
  final (defaultTitle, defaultDescription, defaultRetry) = switch (status) {
    PRFSyncStatus.synced => ('Everything is uploaded', null, null),
    PRFSyncStatus.pending => (
      '${_items(count)} waiting to upload',
      'They will upload automatically when you are back online.',
      'Upload now',
    ),
    PRFSyncStatus.syncing => (
      count > 0 ? 'Uploading ${_items(count)}' : 'Uploading',
      'You can keep using the app.',
      null,
    ),
    PRFSyncStatus.failed => (
      count == 1 ? "1 item couldn't upload" : "$count items couldn't upload",
      'Check your connection and try again.',
      'Try again',
    ),
  };
  final allowsRetry =
      status == PRFSyncStatus.pending || status == PRFSyncStatus.failed;
  return SyncStatusData(
    status: status,
    title: title ?? defaultTitle,
    description: description ?? defaultDescription,
    progress: progress?.clamp(0, 1).toDouble(),
    currentItemLabel: status == PRFSyncStatus.syncing ? currentItemLabel : null,
    onRetry: allowsRetry ? onRetry : null,
    retryLabel: retryLabel ?? defaultRetry,
    onViewDetails: onViewDetails,
    viewDetailsLabel: viewDetailsLabel,
  );
}

/// Background, border and accent colours for a status.
({Color background, Color border, Color accent}) syncStatusColors(
  BuildContext context,
  PRFSyncStatus status,
) {
  final scheme = Theme.of(context).colorScheme;
  final statusColors = context.statusColors;
  return switch (status) {
    PRFSyncStatus.synced => (
      background: statusColors.success.background,
      border: statusColors.success.main.withValues(alpha: PRFOpacities.glow),
      accent: statusColors.success.main,
    ),
    PRFSyncStatus.failed => (
      background: statusColors.error.background,
      border: statusColors.error.main.withValues(alpha: PRFOpacities.glow),
      accent: statusColors.error.main,
    ),
    PRFSyncStatus.pending || PRFSyncStatus.syncing => (
      background: scheme.surfaceContainer,
      border: scheme.outlineVariant,
      accent: scheme.primary,
    ),
  };
}

IconData syncStatusIcon(PRFSyncStatus status) => switch (status) {
  PRFSyncStatus.synced => Icons.cloud_done_outlined,
  PRFSyncStatus.pending => Icons.cloud_queue_outlined,
  PRFSyncStatus.syncing => Icons.cloud_upload_outlined,
  PRFSyncStatus.failed => Icons.cloud_off_outlined,
};

/// Bordered container for the bar.
Widget buildSyncStatusSurface(
  BuildContext context, {
  required PRFSyncStatus status,
  required EdgeInsets padding,
  required Widget child,
}) {
  final colors = syncStatusColors(context, status);
  return Container(
    width: double.infinity,
    padding: padding,
    decoration: BoxDecoration(
      color: colors.background,
      borderRadius: BorderRadius.circular(PRFRadiusTokens.smd),
      border: Border.all(color: colors.border),
    ),
    child: child,
  );
}

/// Icon + title + description + progress block. The title is a live region
/// so screen readers announce status changes.
Widget buildSyncStatusText(
  BuildContext context, {
  required SyncStatusData data,
}) {
  final theme = Theme.of(context);
  final scheme = theme.colorScheme;
  final accent = syncStatusColors(context, data.status).accent;
  final percent = data.progress == null
      ? null
      : '${(data.progress! * 100).round()}%';

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(
        syncStatusIcon(data.status),
        size: PRFSizeTokens.iconLg,
        color: accent,
      ),
      const SizedBox(width: PRFSpacingTokens.md),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              liveRegion: true,
              child: Text(
                percent == null ? data.title : '${data.title} · $percent',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (data.description != null) ...[
              const SizedBox(height: PRFSpacingTokens.xs),
              Text(
                data.description!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
            if (data.isSyncing) ...[
              const SizedBox(height: PRFSpacingTokens.sm),
              LinearProgressIndicator(
                value: data.progress,
                minHeight: PRFSizeTokens.progressBarHeight,
                borderRadius: BorderRadius.circular(PRFRadiusTokens.xs),
                color: scheme.primary,
                backgroundColor: scheme.surfaceContainerHighest,
                semanticsLabel: data.title,
                semanticsValue: percent,
              ),
              if (data.currentItemLabel != null) ...[
                const SizedBox(height: PRFSpacingTokens.xs),
                Text(
                  data.currentItemLabel!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ],
        ),
      ),
    ],
  );
}

/// Secondary "View" button, ≥48 dp.
Widget buildSyncDetailsButton(
  BuildContext context, {
  required VoidCallback onPressed,
  required String label,
}) {
  final scheme = Theme.of(context).colorScheme;
  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      foregroundColor: scheme.primary,
      side: BorderSide(color: scheme.outline),
      minimumSize: const Size(
        PRFSizeTokens.minTouchTarget,
        PRFSizeTokens.minTouchTarget,
      ),
      padding: const EdgeInsets.symmetric(horizontal: PRFSpacingTokens.lg),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PRFRadiusTokens.smd),
      ),
    ),
    child: Text(label, textAlign: TextAlign.center),
  );
}
