// Shared PDF loading state for PDFViewerPage variants.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';

class PDFViewerState {
  PdfControllerPinch? controller;
  bool isLoading = true;
  String? error;

  Future<void> loadPdf(String url, VoidCallback rebuild) async {
    isLoading = true;
    error = null;
    rebuild();

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 30));

      if (response.statusCode != 200) {
        throw Exception('Failed to download PDF: ${response.statusCode}');
      }

      controller = PdfControllerPinch(
        document: PdfDocument.openData(response.bodyBytes),
      );
      isLoading = false;
      rebuild();
    } on Exception catch (e) {
      isLoading = false;
      error = 'Failed to load PDF: $e';
      rebuild();
    }
  }

  void dispose() => controller?.dispose();
}
