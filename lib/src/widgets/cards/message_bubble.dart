import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';

/// Chat message bubble with timestamp and optional delivery status.
///
/// Incoming messages use the secondary-container colour and align left;
/// outgoing messages use the primary colour and align right. When
/// [showStatusIndicator] is true a check icon appears next to the timestamp.
///
/// Example:
/// ```dart
/// PRFMessageBubble(
///   message: message.text,
///   timestamp: message.sentAtLabel,
///   isIncoming: message.isIncoming,
///   showStatusIndicator: message.isOutgoing && message.isRead,
/// )
/// ```
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

  /// The message text.
  final String message;

  /// Timestamp label rendered under the bubble.
  final String timestamp;

  /// When true the bubble is styled as an incoming (left) message.
  final bool isIncoming;

  /// When true a check-circle indicator follows the timestamp.
  final bool showStatusIndicator;

  /// Overrides the default outer margin.
  final EdgeInsetsGeometry? margin;

  /// Overrides the default 75%-width bubble constraint.
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
                topLeft: const Radius.circular(PRFRadiusTokens.lg),
                topRight: const Radius.circular(PRFRadiusTokens.lg),
                bottomLeft: Radius.circular(
                  isIncoming ? PRFRadiusTokens.xs : PRFRadiusTokens.lg,
                ),
                bottomRight: Radius.circular(
                  isIncoming ? PRFRadiusTokens.lg : PRFRadiusTokens.xs,
                ),
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
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
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
