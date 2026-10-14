import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/buttons/prf_button.dart';
import 'package:prf_design/src/widgets/states/error_view/_shared.dart';

/// Handset layout for PRFErrorView. Internal — prefer the parent widget.
class PRFErrorViewHandset extends StatelessWidget {
  const PRFErrorViewHandset({required this.config, super.key});

  final ErrorViewConfig config;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final failure = config.failure;
    final icon = errorIcon(failure);
    final onRetry = config.onRetry;

    if (config.compact) {
      // Narrow rows: stack the labelled retry under the text so the message
      // keeps the full width at large text sizes.
      return Semantics(
        label: config.semanticLabel,
        liveRegion: true,
        child: Padding(
          padding: const EdgeInsets.all(PRFSpacingTokens.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ExcludeSemantics(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCompactErrorIcon(
                      context,
                      icon: icon,
                      padding: PRFSpacingTokens.sm,
                    ),
                    const SizedBox(width: PRFSpacingTokens.md),
                    Expanded(
                      child: buildCompactErrorText(
                        context,
                        title: config.title,
                        message: failure.message,
                        titleStyle: theme.textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: PRFSpacingTokens.sm),
                // Indent by the icon tile width so, with the button's own
                // padding, its icon lines up under the message text.
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: PRFSizeTokens.iconLg + PRFSpacingTokens.sm * 2,
                  ),
                  child: buildCompactRetryButton(
                    context,
                    onRetry: onRetry,
                    label: config.retryLabel,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Semantics(
      label: config.semanticLabel,
      liveRegion: true,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(PRFSpacingTokens.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ExcludeSemantics(
                child: Column(
                  children: [
                    buildErrorIcon(
                      context,
                      theme: theme,
                      icon: icon,
                      size: PRFSizeTokens.iconXxxl,
                      containerPadding: PRFSpacingTokens.xl,
                    ),
                    const SizedBox(height: PRFSpacingTokens.lg),
                    buildErrorTitle(context, theme: theme, title: config.title),
                    const SizedBox(height: PRFSpacingTokens.sm),
                    buildErrorMessage(
                      context,
                      theme: theme,
                      message: failure.message,
                    ),
                  ],
                ),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: PRFSpacingTokens.xl),
                buildRetryButton(
                  context,
                  button: PRFButton(
                    onPressed: onRetry,
                    title: config.retryLabel,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
