import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/widgets/dialogs/bottom_sheet.dart';
import 'package:prf_design/src/widgets/dialogs/media_source_sheet/_handset.dart';
import 'package:prf_design/src/widgets/dialogs/media_source_sheet/_shared.dart';
import 'package:prf_design/src/widgets/dialogs/media_source_sheet/_tablet.dart';

/// Where the user wants to get a photo, video or document from.
enum PRFMediaSource {
  /// Capture with the device camera.
  camera,

  /// Pick from the photo library.
  gallery,

  /// Pick a file from device storage.
  file,
}

/// Localisable text for [PRFMediaSourceSheet]. English defaults.
@immutable
class PRFMediaSourceLabels {
  const PRFMediaSourceLabels({
    this.title = 'Choose a source',
    this.camera = 'Camera',
    this.cameraDescription = 'Take a photo',
    this.gallery = 'Gallery',
    this.galleryDescription = 'Choose from your photos',
    this.file = 'Files',
    this.fileDescription = 'Choose a document',
  });

  /// Sheet heading.
  final String title;

  /// Camera option name.
  final String camera;

  /// Camera option help text. Use e.g. "Record a video" for video capture.
  final String cameraDescription;

  /// Gallery option name.
  final String gallery;

  /// Gallery option help text.
  final String galleryDescription;

  /// File option name.
  final String file;

  /// File option help text.
  final String fileDescription;
}

/// Shows a bottom sheet asking where to get media from, and resolves with
/// the chosen [PRFMediaSource] (or null if dismissed).
///
/// Each option is a large, labelled row (a side-by-side card on tablet) with
/// an icon and a short explanation. Only the [sources] given are offered, in
/// that order.
///
/// Example:
/// ```dart
/// final source = await showPRFMediaSourceSheet(
///   context,
///   labels: PRFMediaSourceLabels(
///     title: l10n.chooseSource,
///     camera: l10n.camera,
///     cameraDescription: isVideo ? l10n.recordVideo : l10n.takePhoto,
///     gallery: l10n.gallery,
///     galleryDescription: l10n.chooseFromGallery,
///   ),
/// );
/// if (source == PRFMediaSource.camera) { ... }
/// ```
Future<PRFMediaSource?> showPRFMediaSourceSheet(
  BuildContext context, {
  List<PRFMediaSource> sources = const [
    PRFMediaSource.camera,
    PRFMediaSource.gallery,
  ],
  PRFMediaSourceLabels labels = const PRFMediaSourceLabels(),
}) {
  return PRFBottomSheet.show<PRFMediaSource>(
    context,
    title: labels.title,
    child: Builder(
      builder: (sheetContext) => PRFMediaSourceSheet(
        sources: sources,
        labels: labels,
        onSelected: (source) => Navigator.of(sheetContext).pop(source),
      ),
    ),
  );
}

/// Body of the media-source picker: one large labelled option per source.
///
/// Usually shown via [showPRFMediaSourceSheet]; use directly to embed the
/// options in your own surface.
class PRFMediaSourceSheet extends StatelessWidget {
  const PRFMediaSourceSheet({
    required this.onSelected,
    this.sources = const [PRFMediaSource.camera, PRFMediaSource.gallery],
    this.labels = const PRFMediaSourceLabels(),
    super.key,
  });

  /// Invoked with the source the user tapped.
  final ValueChanged<PRFMediaSource> onSelected;

  /// Sources to offer, in display order.
  final List<PRFMediaSource> sources;

  /// Option text.
  final PRFMediaSourceLabels labels;

  @override
  Widget build(BuildContext context) {
    final options = [
      for (final source in sources) mediaSourceOption(source, labels),
    ];
    return PRFAdaptive(
      handset: (_) =>
          PRFMediaSourceSheetHandset(options: options, onSelected: onSelected),
      tablet: (_) =>
          PRFMediaSourceSheetTablet(options: options, onSelected: onSelected),
      builder: (_, _) =>
          PRFMediaSourceSheetTablet(options: options, onSelected: onSelected),
    );
  }
}
