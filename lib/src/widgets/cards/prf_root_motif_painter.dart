import 'package:flutter/material.dart';

/// "The Living Root" brand motif: organic growth arcs rising across a dark
/// surface, tipped with lime nodes.
///
/// Use as the background layer of full-bleed navy brand panels so the motif
/// stays continuous across surfaces (auth, home, etc.). The lime node tips
/// are the only accent — keep them that way on any surface using this
/// painter.
///
/// Example:
/// ```dart
/// Stack(
///   children: [
///     const Positioned.fill(
///       child: DecoratedBox(
///         decoration: BoxDecoration(color: PRFColors.navyBlue),
///         child: CustomPaint(painter: PRFRootMotifPainter()),
///       ),
///     ),
///     // panel content...
///   ],
/// )
/// ```
class PRFRootMotifPainter extends CustomPainter {
  const PRFRootMotifPainter({
    this.stemColor = const Color(0x24FFFFFF),
    this.nodeColor = const Color(0x8C9DE35D),
    this.faintNodeColor = const Color(0x38FFFFFF),
  });

  /// Color of the growth arc strokes.
  final Color stemColor;

  /// Fill color of the lime node tips.
  final Color nodeColor;

  /// Fill color of the faint offshoot nodes.
  final Color faintNodeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final origin = Offset(w * 0.16, h * 0.94);

    final stemPaint = Paint()
      ..color = stemColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final nodePaint = Paint()
      ..color = nodeColor
      ..style = PaintingStyle.fill;

    final faintNodePaint = Paint()
      ..color = faintNodeColor
      ..style = PaintingStyle.fill;

    void branch(
      double c1x,
      double c1y,
      double c2x,
      double c2y,
      double ex,
      double ey,
      double strokeWidth,
    ) {
      final end = Offset(w * ex, h * ey);
      canvas
        ..drawPath(
          Path()
            ..moveTo(origin.dx, origin.dy)
            ..cubicTo(w * c1x, h * c1y, w * c2x, h * c2y, end.dx, end.dy),
          stemPaint..strokeWidth = strokeWidth,
        )
        ..drawCircle(end, strokeWidth + 1.4, nodePaint);
    }

    branch(0.30, 0.62, 0.52, 0.34, 0.90, 0.16, 3.2);
    branch(0.26, 0.70, 0.44, 0.50, 0.68, 0.28, 2.6);
    branch(0.22, 0.58, 0.36, 0.30, 0.54, 0.10, 2.2);
    branch(0.32, 0.80, 0.58, 0.66, 0.86, 0.46, 1.8);
    branch(0.20, 0.74, 0.30, 0.48, 0.40, 0.24, 1.5);

    // Faint offshoot nodes along the boldest arcs.
    canvas
      ..drawCircle(Offset(w * 0.47, h * 0.42), 3, faintNodePaint)
      ..drawCircle(Offset(w * 0.60, h * 0.60), 2.4, faintNodePaint)
      ..drawCircle(Offset(w * 0.33, h * 0.55), 2.8, faintNodePaint);
  }

  @override
  bool shouldRepaint(covariant PRFRootMotifPainter oldDelegate) =>
      oldDelegate.stemColor != stemColor ||
      oldDelegate.nodeColor != nodeColor ||
      oldDelegate.faintNodeColor != faintNodeColor;
}
