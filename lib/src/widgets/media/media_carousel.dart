import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// A media item for the carousel.
class PRFCarouselItem {
  const PRFCarouselItem({
    required this.url,
    required this.isVideo,
    this.id,
  });

  final String url;
  final bool isVideo;
  final String? id;
}

/// Full-screen media carousel with swipe navigation, zoom, and action buttons.
///
/// Replaces `ImagePreviewPage` with support for actions (delete, save)
/// and video items via a builder callback.
class PRFMediaCarousel extends StatefulWidget {
  const PRFMediaCarousel({
    required this.items,
    required this.initialIndex,
    this.onDelete,
    this.onSave,
    this.videoBuilder,
    super.key,
  });

  final List<PRFCarouselItem> items;
  final int initialIndex;

  /// Called when the user taps the delete button. Receives the item index.
  final Future<bool> Function(int index)? onDelete;

  /// Called when the user taps the save/download button. Receives the item.
  final Future<void> Function(PRFCarouselItem item)? onSave;

  /// Builder for video pages. If null, videos show a placeholder.
  final Widget Function(BuildContext context, PRFCarouselItem item)?
  videoBuilder;

  /// Opens the carousel as a full-screen route.
  static Future<void> show(
    BuildContext context, {
    required List<PRFCarouselItem> items,
    required int initialIndex,
    Future<bool> Function(int index)? onDelete,
    Future<void> Function(PRFCarouselItem item)? onSave,
    Widget Function(BuildContext context, PRFCarouselItem item)? videoBuilder,
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) =>
            PRFMediaCarousel(
              items: items,
              initialIndex: initialIndex,
              onDelete: onDelete,
              onSave: onSave,
              videoBuilder: videoBuilder,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          if (MediaQuery.of(context).disableAnimations) return child;
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  State<PRFMediaCarousel> createState() => _PRFMediaCarouselState();
}

class _PRFMediaCarouselState extends State<PRFMediaCarousel> {
  late PageController _pageController;
  late int _currentIndex;
  late List<PRFCarouselItem> _items;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _items = List.of(widget.items);
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleControls() {
    setState(() => _showControls = !_showControls);
  }

  Future<void> _handleDelete() async {
    if (widget.onDelete == null) return;

    final deleted = await widget.onDelete!(_currentIndex);
    if (!deleted || !mounted) return;

    setState(() {
      _items.removeAt(_currentIndex);
      if (_items.isEmpty) {
        Navigator.of(context).pop();
        return;
      }
      if (_currentIndex >= _items.length) {
        _currentIndex = _items.length - 1;
      }
    });
  }

  Future<void> _handleSave() async {
    if (widget.onSave == null) return;
    await widget.onSave!(_items[_currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: PRFColors.black,
        body: Stack(
          children: [
            // Media pages
            GestureDetector(
              onTap: _toggleControls,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  if (item.isVideo && widget.videoBuilder != null) {
                    return widget.videoBuilder!(context, item);
                  }
                  return _ImagePage(imageUrl: item.url);
                },
              ),
            ),

            // Top controls
            if (_showControls)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _TopBar(
                  currentIndex: _currentIndex,
                  totalCount: _items.length,
                  onClose: () => Navigator.of(context).pop(),
                  onDelete: widget.onDelete != null ? _handleDelete : null,
                  onSave: widget.onSave != null ? _handleSave : null,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.currentIndex,
    required this.totalCount,
    required this.onClose,
    this.onDelete,
    this.onSave,
  });

  final int currentIndex;
  final int totalCount;
  final VoidCallback onClose;
  final VoidCallback? onDelete;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xCC000000),
            Color(0x00000000),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: PRFSpacingTokens.sm,
            vertical: PRFSpacingTokens.xs,
          ),
          child: Row(
            children: [
              // Close button
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close, color: PRFColors.white),
                tooltip: 'Close',
              ),

              const Spacer(),

              // Counter
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: PRFSpacingTokens.md,
                  vertical: PRFSpacingTokens.xs,
                ),
                decoration: BoxDecoration(
                  color: PRFColors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(PRFRadiusTokens.lg),
                ),
                child: Text(
                  '${currentIndex + 1} of $totalCount',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: PRFColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Spacer(),

              // Action buttons
              if (onSave != null)
                IconButton(
                  onPressed: onSave,
                  icon: const Icon(
                    Icons.download_rounded,
                    color: PRFColors.white,
                  ),
                  tooltip: 'Save to device',
                ),
              if (onDelete != null)
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: PRFColors.white,
                  ),
                  tooltip: 'Delete',
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImagePage extends StatelessWidget {
  const _ImagePage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 4,
      child: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return ColoredBox(
              color: theme.colorScheme.surfaceContainerHighest,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_not_supported,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load image',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
                color: PRFColors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
