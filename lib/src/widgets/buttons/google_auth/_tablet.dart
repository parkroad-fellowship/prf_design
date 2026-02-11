import 'package:flutter/material.dart';

class GoogleAuthButtonTablet extends StatelessWidget {
  const GoogleAuthButtonTablet({
    required this.onPressed,
    required this.title,
    required this.disabled,
    super.key,
    this.isLoading,
    this.googleLogoAsset,
  });

  final VoidCallback onPressed;
  final String title;
  final bool disabled;
  final bool? isLoading;
  final Widget? googleLogoAsset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 72,
      child: OutlinedButton(
        onPressed: (disabled || (isLoading ?? false)) ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: theme.colorScheme.onSurface,
          side: BorderSide(
            color: theme.colorScheme.outline,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading ?? false)
              SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                  strokeWidth: 2.5,
                ),
              )
            else if (googleLogoAsset != null)
              SizedBox(
                height: 24,
                width: 24,
                child: googleLogoAsset,
              )
            else
              const SizedBox(width: 24, height: 24),
            const SizedBox(width: 16),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
