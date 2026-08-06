import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/inputs/prf_text_field.dart';

/// Fixed message-composing bar with a send button.
///
/// Pinned at the bottom of a chat screen. The send button only activates once
/// [isComposing] is true, and shows a spinner while [isLoading]. Use
/// [bottomInset] to clear the on-screen keyboard inset.
///
/// Example:
/// ```dart
/// PRFReplyComposer(
///   controller: _replyController,
///   hintText: 'Reply…',
///   isComposing: _replyController.text.trim().isNotEmpty,
///   isLoading: _sending,
///   onSend: _sendReply,
/// )
/// ```
class PRFReplyComposer extends StatelessWidget {
  const PRFReplyComposer({
    required this.controller,
    required this.hintText,
    required this.isComposing,
    required this.isLoading,
    required this.onSend,
    super.key,
    this.enabled = true,
    this.hasFocus = false,
    this.bottomInset = 0,
    this.minLines = 1,
    this.maxLines = 4,
  });

  /// The editing controller for the message text.
  final TextEditingController controller;

  /// Placeholder shown while the field is empty.
  final String hintText;

  /// When true the send button is active (e.g. the text is non-empty).
  final bool isComposing;

  /// When true a spinner replaces the send icon and input is disabled.
  final bool isLoading;

  /// Invoked when the send button is pressed.
  final VoidCallback onSend;

  /// When false the composer is non-interactive.
  final bool enabled;

  /// Drives the focused border colour of the input.
  final bool hasFocus;

  /// Vertical inset to clear the on-screen keyboard.
  final double bottomInset;

  /// Minimum visible lines of the input.
  final int minLines;

  /// Maximum visible lines of the input before it scrolls.
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: PRFSpacingTokens.lg,
          right: PRFSpacingTokens.lg,
          bottom: bottomInset + PRFSpacingTokens.lg,
          top: PRFSpacingTokens.md,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(PRFRadiusTokens.xl),
                  border: Border.all(
                    color: hasFocus
                        ? theme.colorScheme.primary.withValues(alpha: 0.5)
                        : theme.colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                child: PRFTextField(
                  hintText: hintText,
                  controller: controller,
                  type: PRFTextFieldType.textArea,
                  minLines: minLines,
                  maxLines: maxLines,
                  enabled: enabled && !isLoading,
                ),
              ),
            ),
            const SizedBox(width: PRFSpacingTokens.md),
            AnimatedContainer(
              duration: PRFMotionTokens.standard,
              decoration: BoxDecoration(
                gradient: isComposing
                    ? LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary.withValues(alpha: 0.8),
                        ],
                      )
                    : null,
                color: isComposing
                    ? null
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(PRFRadiusTokens.xl),
                boxShadow: isComposing
                    ? [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.3,
                          ),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: IconButton(
                icon: isLoading
                    ? SizedBox(
                        width: PRFSpacingTokens.xl,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isComposing
                                ? Colors.white
                                : theme.colorScheme.primary,
                          ),
                        ),
                      )
                    : Icon(
                        Icons.send_rounded,
                        color: isComposing
                            ? Colors.white
                            : theme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                onPressed: !enabled || isLoading || !isComposing
                    ? null
                    : onSend,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
