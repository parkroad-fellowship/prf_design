import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/utils/device_helper.dart';
import 'package:prf_design/src/widgets/cards/action_card/_shared.dart';

/// Handset layout for PRFActionCard. Internal — prefer the parent widget.
class PRFActionCardHandset extends StatelessWidget {
  const PRFActionCardHandset({
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
      bottomPadding:
          PRFSpacingTokens.xl * DeviceHelper.getScaleFactor(context: context),
      titleStyle: Theme.of(context).textTheme.displayMedium,
    );
  }
}
