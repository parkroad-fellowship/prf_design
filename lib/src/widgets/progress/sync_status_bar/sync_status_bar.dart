import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/widgets/progress/sync_status_bar/_handset.dart';
import 'package:prf_design/src/widgets/progress/sync_status_bar/_shared.dart';
import 'package:prf_design/src/widgets/progress/sync_status_bar/_tablet.dart';

/// Upload / sync states shown by [PRFSyncStatusBar].
enum PRFSyncStatus {
  /// Nothing waiting; everything is uploaded.
  synced,

  /// Items are queued and will upload later (e.g. when back online).
  pending,

  /// Items are uploading now.
  syncing,

  /// Some items failed to upload and need another try.
  failed,
}

/// Presentational banner for offline upload / sync queues.
///
/// Shows the [status] with an icon, a plain-language title and description,
/// an optional progress bar while [PRFSyncStatus.syncing], and labelled 48 dp
/// actions: [onRetry] (shown for pending and failed) and [onViewDetails].
///
/// It holds no service logic: feed it state from your upload service and
/// wire the callbacks. Every visible string can be overridden for
/// localisation; the English defaults are written for non-technical users.
///
/// Example:
/// ```dart
/// PRFSyncStatusBar(
///   status: progress.isRetrying
///       ? PRFSyncStatus.syncing
///       : PRFSyncStatus.pending,
///   count: pending.length,
///   progress: progress.isRetrying ? progress.progress : null,
///   currentItemLabel: progress.currentFileName,
///   onRetry: service.retryAllUploads,
///   onViewDetails: () => _showDetails(context),
/// )
/// ```
class PRFSyncStatusBar extends StatelessWidget {
  const PRFSyncStatusBar({
    required this.status,
    this.count = 0,
    this.progress,
    this.currentItemLabel,
    this.title,
    this.description,
    this.onRetry,
    this.retryLabel,
    this.onViewDetails,
    this.viewDetailsLabel = 'View',
    super.key,
  });

  /// Current state.
  final PRFSyncStatus status;

  /// Number of items queued, uploading or failed.
  final int count;

  /// Upload progress 0–1 while [PRFSyncStatus.syncing]; null shows an
  /// indeterminate bar.
  final double? progress;

  /// Name of the item uploading now, shown under the bar while syncing.
  final String? currentItemLabel;

  /// Overrides the default title (e.g. "3 items waiting to upload").
  final String? title;

  /// Overrides the default description.
  final String? description;

  /// Invoked by the retry button, shown for pending and failed states.
  final VoidCallback? onRetry;

  /// Retry button text. Defaults to "Upload now" (pending) or "Try again"
  /// (failed).
  final String? retryLabel;

  /// Invoked by the details button. When null the button is hidden.
  final VoidCallback? onViewDetails;

  /// Details button text. Defaults to "View".
  final String viewDetailsLabel;

  @override
  Widget build(BuildContext context) {
    final data = resolveSyncStatus(
      status: status,
      count: count,
      progress: progress,
      currentItemLabel: currentItemLabel,
      title: title,
      description: description,
      onRetry: onRetry,
      retryLabel: retryLabel,
      onViewDetails: onViewDetails,
      viewDetailsLabel: viewDetailsLabel,
    );
    return PRFAdaptive(
      handset: (_) => PRFSyncStatusBarHandset(data: data),
      tablet: (_) => PRFSyncStatusBarTablet(data: data),
      builder: (_, _) => PRFSyncStatusBarTablet(data: data),
    );
  }
}
