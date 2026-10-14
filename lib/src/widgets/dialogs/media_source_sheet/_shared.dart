// Shared data and pure builders for PRFMediaSourceSheet variants.
import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/dialogs/media_source_sheet/media_source_sheet.dart';

/// Resolved text and icon for one source option.
@immutable
class MediaSourceOption {
  const MediaSourceOption({
    required this.source,
    required this.label,
    required this.description,
    required this.icon,
  });

  final PRFMediaSource source;
  final String label;
  final String description;
  final IconData icon;
}

MediaSourceOption mediaSourceOption(
  PRFMediaSource source,
  PRFMediaSourceLabels labels,
) {
  return switch (source) {
    PRFMediaSource.camera => MediaSourceOption(
      source: source,
      label: labels.camera,
      description: labels.cameraDescription,
      icon: Icons.photo_camera_outlined,
    ),
    PRFMediaSource.gallery => MediaSourceOption(
      source: source,
      label: labels.gallery,
      description: labels.galleryDescription,
      icon: Icons.photo_library_outlined,
    ),
    PRFMediaSource.file => MediaSourceOption(
      source: source,
      label: labels.file,
      description: labels.fileDescription,
      icon: Icons.folder_open_outlined,
    ),
  };
}

/// Rounded icon tile used by every option.
Widget buildMediaSourceIcon(
  BuildContext context, {
  required IconData icon,
  required double iconSize,
}) {
  final scheme = Theme.of(context).colorScheme;
  return Container(
    padding: const EdgeInsets.all(PRFSpacingTokens.md),
    decoration: BoxDecoration(
      color: scheme.primaryContainer,
      borderRadius: BorderRadius.circular(PRFRadiusTokens.smd),
    ),
    child: Icon(icon, size: iconSize, color: scheme.onPrimaryContainer),
  );
}

/// Tappable bordered surface with button semantics; [child] is the layout.
Widget buildMediaSourceSurface(
  BuildContext context, {
  required MediaSourceOption option,
  required VoidCallback onTap,
  required EdgeInsets padding,
  required Widget child,
}) {
  final scheme = Theme.of(context).colorScheme;
  final radius = BorderRadius.circular(PRFRadiusTokens.md);
  return Semantics(
    button: true,
    label: '${option.label}. ${option.description}',
    onTap: onTap,
    excludeSemantics: true,
    child: Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: PRFSizeTokens.minTouchTarget + PRFSpacingTokens.lg,
          ),
          child: Padding(padding: padding, child: child),
        ),
      ),
    ),
  );
}

/// Option name.
Widget buildMediaSourceLabel(
  BuildContext context, {
  required String label,
  TextAlign? textAlign,
}) {
  final theme = Theme.of(context);
  return Text(
    label,
    textAlign: textAlign,
    style: theme.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w700,
      color: theme.colorScheme.onSurface,
    ),
  );
}

/// Option help text.
Widget buildMediaSourceDescription(
  BuildContext context, {
  required String description,
  TextAlign? textAlign,
}) {
  final theme = Theme.of(context);
  return Text(
    description,
    textAlign: textAlign,
    style: theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    ),
  );
}
