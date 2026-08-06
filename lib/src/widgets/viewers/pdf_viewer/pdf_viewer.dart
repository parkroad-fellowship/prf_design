import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/viewers/pdf_viewer/_handset.dart';
import 'package:prf_design/src/widgets/viewers/pdf_viewer/_tablet.dart';

class PDFViewerPage extends StatelessWidget {
  const PDFViewerPage({
    required this.pdfUrl,
    required this.title,
    super.key,
  });

  final String pdfUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PDFViewerTablet(pdfUrl: pdfUrl, title: title),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PDFViewerHandset(pdfUrl: pdfUrl, title: title),
        tablet: (_, _) => PDFViewerTablet(pdfUrl: pdfUrl, title: title),
      ),
    );
  }
}
