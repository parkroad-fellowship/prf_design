import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:prf_design/src/theme/_index.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';

/// Full-screen PDF viewer.
///
/// The package performs no network I/O — pass the decoded [bytes] and the
/// viewer renders them locally. Shows a spinner while the document opens and
/// an error state (with retry) if it fails.
///
/// Example:
/// ```dart
/// final bytes = await _downloadFile(); // decode yourself
/// await PRFPdfViewer.show(context, bytes: bytes, title: 'Report.pdf');
/// ```
class PRFPdfViewer extends StatefulWidget {
  const PRFPdfViewer({
    required this.bytes,
    required this.title,
    this.errorText = 'Failed to open PDF document.',
    super.key,
  });

  /// Decoded PDF bytes to render.
  final Uint8List bytes;

  /// App bar title.
  final String title;

  /// Message shown when the document cannot be opened.
  final String errorText;

  /// Opens the viewer as a full-screen route.
  static Future<void> show(
    BuildContext context, {
    required Uint8List bytes,
    required String title,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PRFPdfViewer(bytes: bytes, title: title),
      ),
    );
  }

  @override
  State<PRFPdfViewer> createState() => _PRFPdfViewerState();
}

class _PRFPdfViewerState extends State<PRFPdfViewer> {
  PdfControllerPinch? _controller;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_open());
  }

  Future<void> _open() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final controller = PdfControllerPinch(
        document: PdfDocument.openData(widget.bytes),
      );
      if (!mounted) {
        controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _loading = false;
      });
    } on Exception {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = widget.errorText;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        title: Text(widget.title),
      ),
      body: _loading
          ? const Center(child: PRFCircularProgressIndicator())
          : _error != null
          ? _ErrorView(message: _error!, onRetry: _open)
          : _controller != null
          ? PdfViewPinch(
              controller: _controller!,
              backgroundDecoration: BoxDecoration(
                color: theme.colorScheme.surface,
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(PRFSpacingTokens.xxxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: PRFSizeTokens.iconHero,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: PRFSpacingTokens.xl),
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: PRFSpacingTokens.xl),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 280),
                child: ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
