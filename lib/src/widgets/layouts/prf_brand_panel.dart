import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/colors/prf_colors.dart';
import 'package:prf_design/src/theme/extensions/theme_context_extensions.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/cards/prf_root_motif_painter.dart';

/// The navy "Living Root" side panel used on tablet split screens.
///
/// Deep navy surface with the root-motif painting behind a scrollable body.
/// Content should follow the trust-then-action rule: white/navy100 text for
/// information, lime green reserved strictly for actions.
///
/// ```dart
/// PRFBrandPanel(
///   children: [
///     const PRFPanelSectionLabel('Your next mission'),
///     const SizedBox(height: PRFSpacingTokens.md),
///     ...,
///   ],
/// )
/// ```
class PRFBrandPanel extends StatelessWidget {
  const PRFBrandPanel({
    required this.children,
    super.key,
    this.outerPadding = const EdgeInsets.all(PRFSpacingTokens.lg),
    this.bodyPadding = const EdgeInsets.all(PRFSpacingTokens.xl),
    this.scrollable = true,
  });

  /// Panel body, laid out as a top-aligned column and scrolled when
  /// [scrollable] is true so tall content never overflows short windows.
  final List<Widget> children;

  /// Margin around the panel card. Defaults to [PRFSpacingTokens.lg].
  final EdgeInsetsGeometry outerPadding;

  /// Padding inside the panel around the body. Defaults to
  /// [PRFSpacingTokens.xl].
  final EdgeInsetsGeometry bodyPadding;

  /// Whether the body scrolls. Defaults to true; disable only when embedding
  /// a scroll view of your own.
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(PRFRadiusTokens.lg);

    Widget body = Padding(
      padding: bodyPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );

    if (scrollable) {
      body = SingleChildScrollView(child: body);
    }

    return Padding(
      padding: outerPadding,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.prfColors.navyBlue,
          borderRadius: radius,
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: Stack(
            children: [
              const Positioned.fill(
                child: ExcludeSemantics(
                  child: CustomPaint(painter: PRFRootMotifPainter()),
                ),
              ),
              body,
            ],
          ),
        ),
      ),
    );
  }
}

/// Uppercase micro-heading used inside [PRFBrandPanel] sections.
class PRFPanelSectionLabel extends StatelessWidget {
  const PRFPanelSectionLabel(this.label, {super.key});

  /// Label text; rendered uppercase in navy100.
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      label.toUpperCase(),
      style: theme.textTheme.labelMedium?.copyWith(
        color: PRFColors.navy100,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    );
  }
}
