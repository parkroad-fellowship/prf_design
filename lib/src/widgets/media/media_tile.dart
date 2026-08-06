import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// A single media tile for use inside a media grid.
///
/// Handles image loading states, video indicator overlays, and tap callbacks.
/// Uses [Image.network] for image rendering. For advanced loading (e.g.,
/// `ExtendedImage`), wrap the tile or provide a custom [imageBuilder].
///
/// Example:
/// ```dart
/// PRFMediaTile(
///   url: photo.url,
///   isVideo: photo.isVideo,
///   onTap: () => _openMedia(photo),
/// )
/// ```
class PRFMediaTile extends StatelessWidget {
  const PRFMediaTile({
    required this.url,
    this.isVideo = false,
    this.onTap,
    this.imageBuilder,
    this.videoThumbnailBuilder,
    this.height,
    super.key,
  });

  /// The media URL.
  final String url;

  /// Whether this tile represents a video.
  final bool isVideo;

  /// Called when the tile is tapped.
  final VoidCallback? onTap;

  /// Custom image widget builder. If null, uses [Image.network].
  final Widget Function(BuildContext context, String url)? imageBuilder;

  /// Custom video thumbnail builder. If null, shows a gradient placeholder.
  final Widget Function(BuildContext context, String url)?
  videoThumbnailBuilder;

  /// Fixed height for the tile. If null, uses aspect ratio of 1:1.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: isVideo ? 'Video media' : 'Image',
      button: onTap != null,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height ?? 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
            boxShadow: [
              BoxShadow(
                color: PRFColors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(PRFRadiusTokens.md),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Media content
                if (isVideo)
                  _buildVideoContent(context, theme)
                else
                  _buildImageContent(context, theme),

                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        PRFColors.transparent,
                        PRFColors.black.withValues(alpha: 0.15),
                      ],
                    ),
                  ),
                ),

                // Video indicator
                if (isVideo) ...[
                  // Play button
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: PRFColors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: PRFColors.black.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(PRFSpacingTokens.sm),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: theme.colorScheme.primary,
                        size: PRFSizeTokens.iconXl,
                      ),
                    ),
                  ),

                  // Video badge
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: PRFSpacingTokens.sm,
                        vertical: PRFSpacingTokens.xs,
                      ),
                      decoration: BoxDecoration(
                        color: PRFColors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(PRFRadiusTokens.xs),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.videocam_rounded,
                            color: PRFColors.white,
                            size: 12,
                          ),
                          SizedBox(width: 3),
                          Text(
                            'Video',
                            style: TextStyle(
                              color: PRFColors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
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
      ),
    );
  }

  Widget _buildImageContent(BuildContext context, ThemeData theme) {
    if (imageBuilder != null) {
      return imageBuilder!(context, url);
    }

    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return ColoredBox(
          color: theme.colorScheme.errorContainer,
          child: Center(
            child: Icon(
              Icons.broken_image_outlined,
              color: theme.colorScheme.error,
              size: 32,
            ),
          ),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return ColoredBox(
          color: theme.colorScheme.surfaceContainerHighest,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
              color: theme.colorScheme.primary,
            ),
          ),
        );
      },
    );
  }

  Widget _buildVideoContent(BuildContext context, ThemeData theme) {
    if (videoThumbnailBuilder != null) {
      return videoThumbnailBuilder!(context, url);
    }

    // Default gradient placeholder
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.surfaceContainerHigh,
            theme.colorScheme.surfaceContainer,
          ],
        ),
      ),
    );
  }
}
