import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import 'package:prf_design/src/widgets/buttons/google_auth/_handset.dart';
import 'package:prf_design/src/widgets/buttons/google_auth/_tablet.dart';

class PRFGoogleAuthButton extends StatelessWidget {
  const PRFGoogleAuthButton({
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
    return AdaptiveBuilder(
      defaultBuilder: (_, _) => PRFGoogleAuthButtonTablet(
        onPressed: onPressed,
        title: title,
        disabled: disabled,
        isLoading: isLoading,
        googleLogoAsset: googleLogoAsset,
      ),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, _) => PRFGoogleAuthButtonHandset(
          onPressed: onPressed,
          title: title,
          disabled: disabled,
          isLoading: isLoading,
          googleLogoAsset: googleLogoAsset,
        ),
        tablet: (_, _) => PRFGoogleAuthButtonTablet(
          onPressed: onPressed,
          title: title,
          disabled: disabled,
          isLoading: isLoading,
          googleLogoAsset: googleLogoAsset,
        ),
      ),
    );
  }
}
