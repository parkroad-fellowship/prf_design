import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/progress/circular_progress_indicator.dart';
import 'package:prf_design/src/widgets/viewers/pdf_viewer/_shared.dart';

class PDFViewerTablet extends StatefulWidget {
  const PDFViewerTablet({
    required this.pdfUrl,
    required this.title,
    super.key,
  });

  final String pdfUrl;
  final String title;

  @override
  State<PDFViewerTablet> createState() => _PDFViewerTabletState();
}

class _PDFViewerTabletState extends State<PDFViewerTablet> {
  final _state = PDFViewerState();

  @override
  void initState() {
    super.initState();
    _state.loadPdf(widget.pdfUrl, () {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _state.dispose();
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
        toolbarHeight: PRFNavigationTokens.appBarHeightTablet,
      ),
      body: _state.isLoading
          ? const Center(child: PRFCircularProgressIndicator())
          : _state.error != null
          // tablet: error state in a constrained centred card
          ? Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Card(
                  margin: const EdgeInsets.all(PRFSpacingTokens.xxxl),
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
                          _state.error!,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: PRFSpacingTokens.xl),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 280),
                          child: ElevatedButton.icon(
                            onPressed: () => _state.loadPdf(widget.pdfUrl, () {
                              if (mounted) setState(() {});
                            }),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retry'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : _state.controller != null
          ? PdfViewPinch(
              controller: _state.controller!,
              backgroundDecoration: BoxDecoration(
                color: theme.colorScheme.surface,
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
