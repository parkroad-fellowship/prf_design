import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/inputs/text_area/text_area.dart';

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

  final TextEditingController controller;
  final String hintText;
  final bool isComposing;
  final bool isLoading;
  final VoidCallback onSend;
  final bool enabled;
  final bool hasFocus;
  final double bottomInset;
  final int minLines;
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
                child: PRFTextAreaInput(
                  hintText: hintText,
                  controller: controller,
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
