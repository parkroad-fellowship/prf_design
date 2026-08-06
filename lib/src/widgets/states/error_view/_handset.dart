import 'package:flutter/material.dart';
import 'package:prf_design/src/enums/prf_failure.dart';
import 'package:prf_design/src/theme/tokens/_index.dart';
import 'package:prf_design/src/widgets/buttons/prf_button.dart';
import 'package:prf_design/src/widgets/states/error_view/_shared.dart';

/// Handset layout for PRFErrorView. Internal — prefer the parent widget.
class PRFErrorViewHandset extends StatelessWidget {
  const PRFErrorViewHandset({
    required this.failure,
    this.onRetry,
    this.compact = false,
    super.key,
  });

  final PRFFailure failure;
  final VoidCallback? onRetry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final icon = errorIcon(failure);
    final title = errorTitle(failure);

    if (compact) {
      return Semantics(
        label: 'Error: $title. ${failure.message}',
        liveRegion: true,
        child: Padding(
          padding: const EdgeInsets.all(PRFSpacingTokens.lg),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(PRFSpacingTokens.sm),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(PRFRadiusTokens.sm),
                ),
                child: Icon(
                  icon,
                  size: PRFSizeTokens.iconLg,
                  color: theme.colorScheme.error,
                ),
              ),
              const SizedBox(width: PRFSpacingTokens.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      failure.message,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (failure.isRecoverable && onRetry != null)
                IconButton(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  color: theme.colorScheme.primary,
                ),
            ],
          ),
        ),
      );
    }

    return Semantics(
      label: 'Error: $title. ${failure.message}',
      liveRegion: true,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(PRFSpacingTokens.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildErrorIcon(
                context,
                theme: theme,
                icon: icon,
                size: PRFSizeTokens.iconXxxl,
                containerPadding: PRFSpacingTokens.xl,
              ),
              const SizedBox(height: PRFSpacingTokens.lg),
              buildErrorTitle(context, theme: theme, title: title),
              const SizedBox(height: PRFSpacingTokens.sm),
              buildErrorMessage(
                context,
                theme: theme,
                message: failure.message,
              ),
              if (failure.isRecoverable && onRetry != null) ...[
                const SizedBox(height: PRFSpacingTokens.xl),
                buildRetryButton(
                  context,
                  button: PRFButton(
                    onPressed: onRetry!,
                    title: 'Try Again',
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
