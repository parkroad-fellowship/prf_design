import 'package:flutter/material.dart';
import 'package:prf_design/src/widgets/cards/action_card/_shared.dart';

/// Tablet layout for PRFActionCard. Internal — prefer the parent widget.
class PRFActionCardTablet extends StatelessWidget {
  const PRFActionCardTablet({
    required this.title,
    required this.image,
    this.onTap,
    super.key,
  });

  final String title;
  final Widget image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return buildActionCard(
      context,
      title: title,
      image: image,
      onTap: onTap,
      bottomPadding: 0,
      titleStyle: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
