import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/utils/device_helper.dart';

/// Shared body for the action card variants. The variants differ only in
/// bottom padding and title style.
Widget buildActionCard(
  BuildContext context, {
  required String title,
  required Widget image,
  required VoidCallback? onTap,
  required double bottomPadding,
  required TextStyle? titleStyle,
}) {
  final theme = Theme.of(context);
  final scheme = theme.colorScheme;
  final width = MediaQuery.sizeOf(context).width;
  final scaleFactor = DeviceHelper.getScaleFactor(context: context);
  final radius = BorderRadius.circular(PRFRadiusTokens.xxl * scaleFactor);
  // The cut-out and avatar ring blend into the page behind the card, so they
  // follow the scaffold background rather than a fixed white.
  final pageColor = theme.scaffoldBackgroundColor;

  return Semantics(
    button: onTap != null,
    label: title,
    onTap: onTap,
    excludeSemantics: true,
    child: Stack(
      children: [
        Container(
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: PRFSpacingTokens.xs),
          child: Material(
            color: scheme.secondary,
            borderRadius: radius,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  PRFSpacingTokens.xxl * scaleFactor,
                  PRFSpacingTokens.xl * scaleFactor,
                  88 * scaleFactor,
                  bottomPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    image,
                    SizedBox(height: PRFSpacingTokens.xxl * scaleFactor),
                    Text(
                      title,
                      style: titleStyle?.copyWith(
                        color: scheme.onSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: PRFSpacingTokens.lg * scaleFactor),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: PRFSpacingTokens.xs,
          bottom: 0,
          child: IgnorePointer(
            child: ColoredBox(
              color: pageColor,
              child: SizedBox.square(dimension: 60 * scaleFactor),
            ),
          ),
        ),
        Positioned(
          right: PRFSpacingTokens.xs,
          bottom: 0,
          child: GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              backgroundColor: pageColor,
              radius: 40 * scaleFactor,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.primary,
                  shape: BoxShape.circle,
                ),
                child: SizedBox.square(
                  dimension: 70 * scaleFactor,
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: scheme.onPrimary,
                    size: PRFSizeTokens.iconXxl * scaleFactor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
