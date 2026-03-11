import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';

/// A full-screen image preview page with pan and zoom support.
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (_) => ImagePreviewPage(
///       imageUrls: ['url1', 'url2'],
///       initialIndex: 0,
///     ),
///   ),
/// );
/// ```
class ImagePreviewPage extends StatefulWidget {
  const ImagePreviewPage({
    required this.imageUrls,
    required this.initialIndex,
    this.titleBuilder,
    this.appBarTitle,
    super.key,
  });

  /// List of image URLs to display
  final List<String> imageUrls;

  /// The initial page index to display
  final int initialIndex;

  /// Custom title builder for the app bar. If not provided, uses default format
  final String Function(int index, int total)? titleBuilder;

  /// Static app bar title. If provided along with titleBuilder,
  /// titleBuilder takes precedence.
  final String? appBarTitle;

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _getTitle() {
    if (widget.titleBuilder != null) {
      return widget.titleBuilder!(_currentIndex + 1, widget.imageUrls.length);
    }
    if (widget.appBarTitle != null) {
      return '${widget.appBarTitle} ${_currentIndex + 1} of '
          '${widget.imageUrls.length}';
    }
    return 'Image ${_currentIndex + 1} of ${widget.imageUrls.length}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: PRFColors.black,
      appBar: AppBar(
        backgroundColor: PRFColors.black,
        foregroundColor: PRFColors.white,
        title: Text(
          _getTitle(),
          style: theme.textTheme.titleLarge?.copyWith(
            color: PRFColors.white,
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: widget.imageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = widget.imageUrls[index];
          return InteractiveViewer(
            child: Center(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                semanticLabel:
                    'Image ${index + 1} of ${widget.imageUrls.length}',
                errorBuilder: (context, error, stackTrace) {
                  return ColoredBox(
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.4,
                          ),
                          size: 64,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Failed to load image',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.6,
                            ),
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
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
