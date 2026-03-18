import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

class PRFMessageBubble extends StatelessWidget {
  const PRFMessageBubble({
    required this.message,
    required this.timestamp,
    required this.isIncoming,
    super.key,
    this.showStatusIndicator = false,
    this.margin,
    this.maxWidth,
  });

  final String message;
  final String timestamp;
  final bool isIncoming;
  final bool showStatusIndicator;
  final EdgeInsetsGeometry? margin;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bubbleGradient = isIncoming
        ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.secondaryContainer,
              theme.colorScheme.secondaryContainer.withValues(alpha: 0.8),
            ],
          )
        : LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withValues(alpha: 0.9),
            ],
          );

    final bubbleColor = isIncoming
        ? theme.colorScheme.secondaryContainer
        : theme.colorScheme.primary;

    return Container(
      margin:
          margin ??
          const EdgeInsets.symmetric(
            horizontal: PRFSpacingTokens.md,
            vertical: PRFSpacingTokens.xs,
          ),
      child: Column(
        crossAxisAlignment: isIncoming
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: PRFSpacingTokens.lg,
              vertical: PRFSpacingTokens.md,
            ),
            constraints: BoxConstraints(
              maxWidth: maxWidth ?? MediaQuery.sizeOf(context).width * 0.75,
            ),
            decoration: BoxDecoration(
              gradient: bubbleGradient,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isIncoming ? 4 : 20),
                bottomRight: Radius.circular(isIncoming ? 20 : 4),
              ),
              boxShadow: [
                BoxShadow(
                  color: bubbleColor.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isIncoming
                    ? theme.colorScheme.onSecondaryContainer
                    : Colors.white,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: PRFSpacingTokens.xs),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PRFSpacingTokens.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  timestamp,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
                ),
                if (showStatusIndicator) ...[
                  const SizedBox(width: PRFSpacingTokens.xs),
                  Icon(
                    Icons.check_circle,
                    size: 12,
                    color: theme.colorScheme.primary.withValues(alpha: 0.7),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
