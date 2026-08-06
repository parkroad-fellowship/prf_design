import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/utils/device_helper.dart';

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
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final scaleFactor = DeviceHelper.getScaleFactor(context: context);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: width,
            padding: EdgeInsets.fromLTRB(
              PRFSpacingTokens.xxl * scaleFactor,
              PRFSpacingTokens.xl * scaleFactor,
              88 * scaleFactor,
              PRFSpacingTokens.xl * scaleFactor,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: PRFSpacingTokens.xs,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(
                PRFRadiusTokens.xxl * scaleFactor,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                image,
                SizedBox(height: PRFSpacingTokens.xxl * scaleFactor),
                Text(
                  title,
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: PRFSpacingTokens.lg * scaleFactor),
              ],
            ),
          ),
          Positioned(
            right: PRFSpacingTokens.xs,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: SizedBox.square(dimension: 60 * scaleFactor),
            ),
          ),
          Positioned(
            right: PRFSpacingTokens.xs,
            bottom: 0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 40 * scaleFactor,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: SizedBox.square(
                  dimension: 70 * scaleFactor,
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 40 * scaleFactor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
