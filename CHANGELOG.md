# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.8.0] - 2026-03-30

### Added
- Adds an optional navbar to empty states

## [0.7.0] - 2026-03-30

### Added
- Adds `PRFTimelineMissionCard`

## [0.6.0] - 2026-03-20

### Added
- Adds `PRFCarouselItem`
- Adds `PRFMediaGrid`
- Adds `PRFMediaTile`

## [0.5.0] - 2026-03-20

### Added
- Adds `PRFPhoneInput`
- Adds `PRFDomainTabSection`

## [0.4.0] - 2026-03-12

### Changed

- Breaking: `PRFTheme.light` and `PRFTheme.dark` now require an explicit `scaleFactor`.
- Breaking: `PRFTextTheme` APIs now require an explicit `scaleFactor` and no longer accept `BuildContext`.

### Migration

```dart
// Before
theme: PRFTheme.light(context)
darkTheme: PRFTheme.dark(context)

// After
theme: PRFTheme.light(
	scaleFactor: DeviceHelper.getScaleFactor(context: context),
)
darkTheme: PRFTheme.dark(
	scaleFactor: DeviceHelper.getScaleFactor(context: context),
)
```

```dart
// Before
PRFTextTheme.getButtonTextStyle(context)
PRFTextTheme.getErrorTextStyle(context)

// After
PRFTextTheme.getButtonTextStyle(scaleFactor: 1)
PRFTextTheme.getErrorTextStyle(scaleFactor: 1)
```

## [0.3.0] - 2026-02-11

### Added

- `PRFSnackbar` unified snackbar helper with typed variants (`error`, `success`, `info`, `warning`).
- `PRFSnackbarType` enum for snackbar category styling.

### Changed

- Replaced `PRFErrorSnackbar` with `PRFSnackbar` for broader snackbar support beyond errors.
- Removed `publish_to` field from pubspec.yaml (defaults to pub.dev).
- Release workflow now triggers on push to main (when pubspec.yaml changes) and via manual dispatch.

## [0.2.0] - 2026-02-11

### Added

- CI workflow for automated format, analysis, and test checks.
- Release workflow for automated pub.dev publishing and GitHub Releases.
- MIT License, CHANGELOG, and .gitignore.
- Package metadata: `repository`, `homepage`, `issue_tracker` in pubspec.yaml.

### Changed

- Configured package for pub.dev distribution.

## [0.1.0] - 2026-02-11

### Added

- **Theme System**: PRFTheme (light/dark), PRFColors, PRFColorPalette, PRFColorsExtension, PRFStatusExtension, PRFTextTheme with Google Fonts (Lato).
- **Widgets**: PRFPrimaryButton, PRFSecondaryButton, PRFDestroyButton, GoogleAuthButton, PRFEmailInput, PRFPasswordInput, PRFTextInput, FormFieldLabel, PRFCircularProgressIndicator, PRFLinearProgressIndicator, PRFEmptyView, PRFErrorView, PRFErrorSnackbar, PRFCategoryChips, ImagePreviewPage, ReplyStatusView, AnimatedStatCard, StatHighlightCard, PDFViewerPage, WrappedPageIndicator.
- **Utilities**: DeviceHelper, Debouncer, DateFormatter, NumberFormatter, StringFormatter.
- **Models**: PRFFailure, PRFErrorType, PRFErrorSeverity.
