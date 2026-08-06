import 'package:flutter/material.dart';
import 'package:prf_design/src/theme/adaptive/prf_adaptive.dart';
import 'package:prf_design/src/widgets/navigation/_handset.dart';
import 'package:prf_design/src/widgets/navigation/_tablet.dart';

/// Adaptive top navigation bar with back button, title and actions.
///
/// Works as a sliver (the default, for use in `CustomScrollView`) or as a
/// plain `PreferredSizeWidget` when [isSliver] is false. Handset/tablet
/// layouts differ in size and title alignment.
///
/// Example:
/// ```dart
/// CustomScrollView(
///   slivers: [
///     PRFNavBar(
///       title: 'Missions',
///       onBack: () => Navigator.pop(context),
///       actions: [
///         IconButton(icon: const Icon(Icons.filter), onPressed: _filter),
///       ],
///     ),
///     // ...
///   ],
/// )
/// ```
class PRFNavBar extends StatelessWidget {
  const PRFNavBar({
    required this.title,
    super.key,
    this.onBack,
    this.actions,
    this.backIcon,
    this.backgroundColor,
    this.centerTitle = true,
    this.isSliver = true,
  });

  /// Title text.
  final String title;

  /// Invoked when the back button is pressed; defaults to `maybePop`.
  final VoidCallback? onBack;

  /// Optional trailing action widgets.
  final List<Widget>? actions;

  /// Overrides the default back icon.
  final IconData? backIcon;

  /// Overrides the nav-bar background colour.
  final Color? backgroundColor;

  /// When true the title is centred. Defaults to true.
  final bool centerTitle;

  /// When false the nav bar is wrapped in `SafeArea` and usable as an
  /// `AppBar`-style widget (see [PRFAppBar]). Defaults to true (sliver).
  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    final navBar = PRFAdaptive(
      handset: (_) => PRFNavBarHandset(
        title: title,
        onBack: onBack,
        actions: actions,
        backIcon: backIcon,
        backgroundColor: backgroundColor,
        centerTitle: centerTitle,
        isSliver: isSliver,
      ),
      tablet: (_) => PRFNavBarTablet(
        title: title,
        onBack: onBack,
        actions: actions,
        backIcon: backIcon,
        backgroundColor: backgroundColor,
        centerTitle: centerTitle,
        isSliver: isSliver,
      ),
      builder: (_, _) => PRFNavBarTablet(
        title: title,
        onBack: onBack,
        actions: actions,
        backIcon: backIcon,
        backgroundColor: backgroundColor,
        centerTitle: centerTitle,
        isSliver: isSliver,
      ),
    );

    if (!isSliver) {
      return SafeArea(child: navBar);
    }

    return navBar;
  }
}

/// Non-sliver variant of [PRFNavBar] for use as a standard `AppBar`.
///
/// Example:
/// ```dart
/// Scaffold(
///   appBar: PRFAppBar(title: 'Profile', onBack: _close),
///   body: /* ... */,
/// )
/// ```
class PRFAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PRFAppBar({
    required this.title,
    super.key,
    this.onBack,
    this.actions,
    this.backIcon,
    this.backgroundColor,
    this.centerTitle = true,
  });

  /// Title text.
  final String title;

  /// Invoked when the back button is pressed; defaults to `maybePop`.
  final VoidCallback? onBack;

  /// Optional trailing action widgets.
  final List<Widget>? actions;

  /// Overrides the default back icon.
  final IconData? backIcon;

  /// Overrides the app-bar background colour.
  final Color? backgroundColor;

  /// When true the title is centred. Defaults to true.
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return PRFNavBar(
      title: title,
      onBack: onBack,
      actions: actions,
      backIcon: backIcon,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      isSliver: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
