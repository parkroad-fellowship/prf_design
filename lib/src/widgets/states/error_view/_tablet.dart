import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/buttons/prf_button.dart';
import 'package:prf_design/src/widgets/states/error_view/_shared.dart';

/// Tablet layout for PRFErrorView. Internal — prefer the parent widget.
class PRFErrorViewTablet extends StatelessWidget {
  const PRFErrorViewTablet({required this.config, super.key});

  final ErrorViewConfig config;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final failure = config.failure;
    final icon = errorIcon(failure);
    final onRetry = config.onRetry;

    if (config.compact) {
      // Wide rows: the labelled retry sits at the trailing edge.
      return Semantics(
        label: config.semanticLabel,
        liveRegion: true,
        child: Padding(
          padding: const EdgeInsets.all(PRFSpacingTokens.xl),
          child: Row(
            children: [
              ExcludeSemantics(
                child: buildCompactErrorIcon(
                  context,
                  icon: icon,
                  padding: PRFSpacingTokens.md,
                ),
              ),
              const SizedBox(width: PRFSpacingTokens.lg),
              Expanded(
                child: ExcludeSemantics(
                  child: buildCompactErrorText(
                    context,
                    title: config.title,
                    message: failure.message,
                    titleStyle: theme.textTheme.titleMedium,
                  ),
                ),
              ),
              if (onRetry != null) ...[
                const SizedBox(width: PRFSpacingTokens.lg),
                Flexible(
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

    // full-screen: centred column with constrained width for tablet comfort
    return Semantics(
      label: config.semanticLabel,
      liveRegion: true,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: PRFSpacingTokens.xxxl,
            vertical: PRFSpacingTokens.xl,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
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
                        size: PRFSizeTokens.iconHero,
                        containerPadding: PRFSpacingTokens.xxxl,
                      ),
                      const SizedBox(height: PRFSpacingTokens.xl),
                      buildErrorTitle(
                        context,
                        theme: theme,
                        title: config.title,
                      ),
                      const SizedBox(height: PRFSpacingTokens.md),
                      buildErrorMessage(
                        context,
                        theme: theme,
                        message: failure.message,
                      ),
                    ],
                  ),
                ),
                if (onRetry != null) ...[
                  const SizedBox(height: PRFSpacingTokens.xxxl),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 320),
                    child: buildRetryButton(
                      context,
                      button: PRFButton(
                        onPressed: onRetry,
                        title: config.retryLabel,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
