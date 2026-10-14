# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-10-14

### Added

- `StatusColorSet.foreground` — AA-safe text/icon colour for content sitting on
  a status `background` tint (falls back to `main` when not supplied).
- `PRFStatusExtension.all` and `PRFStatusExtension.onColorFor(fill)`, which
  returns the matching set's `onColor` or the more legible of white/navy900.
- `PRFStatusBadge.foregroundColor` override.
- Accessible status tones in `PRFColors`: `warningText`, `orangeText`,
  `emeraldText`, `blueDark`, and dark-mode `successBright`, `errorBright`,
  `infoBright`, `blueBright`.
- Component themes for checkbox, radio, switch, tab bar, list tile, tooltip and
  floating action button, with padded 48dp tap targets.
- Contrast regression test (`test/theme/contrast_test.dart`) asserting WCAG AA
  for every status set and key colour-scheme pair in light and dark.
- `PRFButtonVariant.outlined` and `PRFButtonVariant.text` for secondary and
  low-emphasis actions, an optional leading `PRFButton.icon`, and
  `PRFButton.fullWidth` (set `false` for compact inline buttons that still
  keep a 48dp target).
- `PRFStatPill` — compact value + label pill for header stats, with optional
  icon and `onPrimary` / `container` tones; respects system text scaling.
- `PRFListItemCard` — adaptive list row card (icon tile, title, subtitle,
  active/inactive status, labelled 48dp delete action).
- `PRFNavBarAction` — labelled 48dp header action for `PRFBrandedNavBar`
  (`primary` and `neutral` variants).
- `PRFErrorView.inline` — inline error with a labelled "Try again" button for
  use inside lists and sections; `title` and `retryLabel` on all constructors.
- `showPRFMediaSourceSheet` / `PRFMediaSourceSheet` — camera, gallery and file
  picker sheet with large labelled options (`PRFMediaSource`,
  `PRFMediaSourceLabels`).
- `PRFSyncStatusBar` — presentational upload/sync status bar (`PRFSyncStatus`
  synced, pending, syncing, failed) with retry and progress semantics.
- `PRFDomainTabSection` now owns its `TabController` and accepts
  `initialIndex`, `onTabChanged` and an optional `subtitle`.
- `PRFSearchableList` tablet variant.
- Optional localisable labels: `PRFSearchableList.clearSelectionTooltip`,
  `PRFReplyComposer.sendTooltip`, `PRFMediaTile.videoLabel`,
  `PRFBrandedNavBar.backLabel`, `PRFTimelineDateBadge.onStatusColor`.

### Changed

- Status colours now meet WCAG AA (4.5:1) in both brightnesses. Light-mode
  success, completed, info, initiated and ignored fills are darker; orange
  (pending/scheduled) and emerald (in progress) fills now pair with navy900
  text instead of white; dark-mode fills use bright tones with navy900 text.
  Widgets placing text on `statusColors.*.main` should use `.onColor`.
- Enabled input, unselected checkbox/radio and switch-track borders now reach
  3:1 against their fill (WCAG 1.4.11). Dividers are unchanged.
- `PRFFormFieldLabel` label and "(optional)" text use
  `colorScheme.onSurfaceVariant`, passing AA and adapting to dark mode.
- Light snackbar text and action colours derive from `colorScheme.onPrimary`.
- `PRFColorsExtension` documents which brand colours are fill-only on dark
  surfaces.
- Buttons, category chips, navbar titles, bottom-sheet titles, reply status
  and timeline badges grow with the system text size instead of clipping.
- Every icon-only control has a tooltip and screen-reader label (back, close,
  send, clear, retry); the searchable-list clear action is a 48dp button.
- `PRFButton` exposes its label on the tappable semantics node.
- `PRFActionCard` and `PRFNavigationTile` announce as buttons;
  `PRFActionCard` no longer paints white blocks in dark mode.
- `PRFErrorView` uses plain-language titles (e.g. "No internet connection"),
  scrolls at large text sizes and no longer reads text twice.
- All animations route through `PRFMotionTokens.resolve`; the media grid
  stagger is capped at 400ms.
- Widgets use `PRFSizeTokens`, `PRFOpacities` and `PRFShadowTokens` instead of
  raw values; some disabled and overlay opacities shift slightly.
- `PRFBrandedNavBar` height uses `PRFNavigationTokens.brandedNavBarHeight`.
- `DeviceHelper` classifies devices with `PRFBreakpoints` (desktop now starts
  at 1024dp, matching `PRFAdaptive`); text no longer shrinks from tablet to
  desktop widths, and narrow phones keep `labelSmall` at 11sp or larger.
- `PRFDomainTabSection.subtitle` is now nullable.

### Removed

- The unused Lato font family (692 KB). Manrope is the sole typeface.

## [1.0.8] - 2026-08-22

### Changed

- Downgraded `phone_form_field` from `^11.0.1` to `^10.0.18` and removed the
  `material_ui` dependency. v11 builds on the standalone `material_ui` package
  whose widgets resolve separate Material/Theme/MaterialLocalizations classes,
  which crashed with "No Material widget found" / "No MaterialLocalizations
  found" when `PRFPhoneInput` was rendered inside hosts providing only
  Flutter's widgets (e.g. `showModalBottomSheet`). v10 is the last major built
  on the framework's own Material library and needs no workarounds.

## [1.0.7] - 2026-08-22

### Added

- `PRFOpacities` — shared opacity steps for tinted overlays, borders, glows and
  disabled content (`faint`, `subtle`, `hairline`, `muted`, `glow`, `accent`,
  `half`, `prominent`, `high`, `stronger`, `nearOpaque`), exported from the
  tokens barrel.

## [1.0.6] - 2026-08-22
### Added
- Added extra tokens


## [1.0.3] - 2026-08-22

### Added

- New `layouts` widget category, exported from the main widgets barrel.
- `PRFTabletSplitScaffold` — canonical tablet geometry for list/detail screens:
  centered max-width stage with a content column and side panel column
  separated by a hairline divider (configurable flex weights and max width).
- `PRFBrandPanel` — navy "Living Root" side panel used on tablet split screens,
  with root-motif painting behind an optionally scrollable body.
- `PRFTabletHeaderRow` — tablet screen header with back navigation, an
  ellipsizing title, an optional inline loading spinner slot, and trailing
  actions.

### Changed

- `PRFTimelineMissionCard` now uses an `InkWell` for tap ripple feedback
  instead of a bare `GestureDetector`.
- `PRFTimelineMissionCard` exposes `Semantics` (button role, school/status
  label, action hint) for accessibility.
- Capacity info chip on `PRFTimelineMissionCard` uses `colorScheme.primary`.

## [1.0.2] - 2026-08-06

### Added

- `PRFAdaptive` + `PRFBreakpoints` adaptive layer, replacing `flutter_adaptive_ui`.
- Unified `PRFButton` (primary/secondary/destructive/google variants).
- Unified `PRFTextField` (text/email/name/number/password/textArea types).
- `PRFPdfViewer` taking decoded `Uint8List` bytes (no network I/O in the package).
- Offline Manrope/Lato fonts declared as Flutter font assets.

### Changed

- Rewritten `PRFColors` as the single source of truth for every hex value
  (brand anchors, navy/lime 10-stop palettes, grays, status, accents).
- `PRFTheme` now uses a hand-authored Material 3 `ColorScheme` per brightness;
  dropped `PRFThemeConfig` and index-flipping palettes.
- `PRFTheme.light`/`dark` accept optional `colors:` (`PRFBaseColors`, scheme
  derived from Material 3 tonal palettes) and `colorScheme:` (full override) so
  consuming apps can bring their own palette.
- Token values re-based on a 4px spacing grid and fixed radius scale.
- `PRFMediaCarousel` copy (tooltips, image error text) is now parameterized.
- `PRFPhoneInput` accepts a `countries` list (defaults to Kenya).
- Button and input widgets consolidated from per-variant folders into a single
  adaptive implementation.

### Removed

- Dependencies: `flutter_adaptive_ui`, `google_fonts`, `http`.
- Widgets with no consumers: `ImagePreviewPage`, `AnimatedStatCard`,
  `StatHighlightCard`.
- Backwards-compatible wrapper widgets: `PRFPrimaryButton`,
  `PRFSecondaryButton`, `PRFDestroyButton`, `PRFGoogleAuthButton`,
  `PRFTextInput`, `PRFEmailInput`, `PRFNameInput`, `PRFNumberInput`,
  `PRFPasswordInput`, `PRFTextAreaInput` — use `PRFButton`/`PRFTextField`
  directly (see `docs/migration_guide.md`).
- `PRFThemeConfig`, `PRFTextTheme.getErrorTextStyle`/`getSuccessTextStyle`/
  `getWarningTextStyle`/`getInfoTextStyle`/`getCaptionTextStyle`.

## [0.9.7] - 2026-06-06

### Added
- Add support for extending the color scheme for an organisation

## [0.8.4] - 2026-06-23

### Added
- Add `PRFSchoolCard`

## [0.8.3] - 2026-04-23

### Added
- Fix bouncy scroll on list selection

## [0.8.2] - 2026-04-03

### Added
- Update tablet designs

## [0.8.1] - 2026-04-03

### Added
- Minor padding on the error view
- Updated usage docs

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
