# Migration Guide: 0.x → 1.0.0

`prf_design` 1.0.0 is a cleanup release: the theme system was rebuilt around a
single color source and offline fonts, the adaptive layer replaced
`flutter_adaptive_ui`, and buttons/inputs were consolidated. Public names that
consumers actually use were kept; here is everything that changed.

## Quick summary

| Area | What happened |
|------|---------------|
| Adaptive layer | `flutter_adaptive_ui` removed; use `PRFAdaptive` + `PRFBreakpoints` |
| Fonts | `google_fonts` removed; Manrope/Lato ship as offline assets |
| Colors | `PRFColors` is the single hex source; `PRFColorPalette` forwards to it |
| Theme | `PRFTheme` unchanged API; no more `PRFThemeConfig` |
| Buttons | wrapper variants removed; use `PRFButton` with `variant` |
| Inputs | wrapper variants removed; use `PRFTextField` with `type` |
| PDF | `PDFViewerPage` → `PRFPdfViewer` (pass bytes, not a URL) |
| Networking | `http` removed — the package performs no network I/O |

## Adaptive builder

Replace `AdaptiveBuilder` from `flutter_adaptive_ui`:

```dart
// Before
AdaptiveBuilder(
  defaultBuilder: (_, _) => PRFMyWidgetTablet(...),
  layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
    handset: (_, _) => PRFMyWidgetHandset(...),
    tablet: (_, _) => PRFMyWidgetTablet(...),
  ),
)

// After
PRFAdaptive(
  handset: (_) => PRFMyWidgetHandset(...),
  tablet: (_) => PRFMyWidgetTablet(...),
  builder: (_, _) => PRFMyWidgetTablet(...),
)
```

`PRFAdaptive` accepts optional `handset`/`tablet`/`desktop` builders and a
required `builder` fallback. Breakpoints: `handset` <600, `tablet` <1024,
`desktop` ≥1024. Helpers live on `PRFBreakpoints`:

```dart
PRFBreakpoints.of(context)
PRFBreakpoints.fromWidth(width)
PRFBreakpoints.isTabletOrWider(context)
```

## Fonts

Remove `google_fonts` from your `pubspec.yaml` if it was only used via
`prf_design`. Manrope (display/UI) and Lato (body) are declared as Flutter font
assets in the package, so `TextStyle(fontFamily: 'Manrope')` works offline.

Tests that called `GoogleFonts.config.allowRuntimeFetching = false` can drop that line.

## Colors

- `PRFColors` is the single source of truth for raw hex values.
- `PRFColorPalette` still exists as a thin facade over `PRFColors` (for the
  Leadership app's palette imports). Prefer `PRFColors` directly.
- Widget layout code should read `theme.colorScheme` or `context.prfColors`,
  never `PRFColors.*` literals.

## Theme

- `PRFTheme.light(scaleFactor:, colorScheme:, colors:)` /
  `PRFTheme.dark(scaleFactor:, colorScheme:, colors:)` keep the same
  signatures and still return Material 3 `ThemeData`.
- New optional parameters let your app bring its own palette: `colors:`
  (`PRFBaseColors` — the theme derives on-colours/containers from Material 3
  tonal palettes) or `colorScheme:` (a full scheme, takes precedence). Omit
  both to use the hand-authored PRF scheme.
- `PRFThemeConfig` was removed — it had no consumers. Pass `scaleFactor` directly.
- `PRFTextTheme.getErrorTextStyle` / `getSuccessTextStyle` / `getWarningTextStyle`
  / `getInfoTextStyle` / `getCaptionTextStyle` were removed. Use the theme's
  `TextTheme` plus `theme.colorScheme` instead.

## Buttons

The typed wrapper widgets (`PRFPrimaryButton`, `PRFSecondaryButton`,
`PRFDestroyButton`, `PRFGoogleAuthButton`) were removed. Use the unified
`PRFButton` and select the look through `variant`:

```dart
PRFButton(
  onPressed: ...,
  title: ...,
  variant: PRFButtonVariant.primary, // primary | secondary | destructive | google
  disabled: false,
  isLoading: false,
)
```

## Inputs

The typed wrapper widgets (`PRFTextInput`, `PRFEmailInput`, `PRFNameInput`,
`PRFNumberInput`, `PRFPasswordInput`, `PRFTextAreaInput`) were removed. Use the
unified `PRFTextField` and select the behaviour through `type`
(`text | email | name | number | password | textArea`):

```dart
PRFTextField(hintText: ..., controller: ..., type: PRFTextFieldType.text)
PRFTextField(hintText: ..., controller: ..., type: PRFTextFieldType.password, obscureNotifier: ...)
PRFTextField(hintText: ..., controller: ..., type: PRFTextFieldType.number, prefixText: 'KES')
PRFTextField(hintText: ..., controller: ..., type: PRFTextFieldType.textArea, minLines: 3, maxLines: 5)
```

See the README for the full `PRFTextField` signature.

## PDF viewer

`PDFViewerPage` (URL-based) was replaced by `PRFPdfViewer` (bytes-based). The
package no longer depends on `http` — decode the file in your app and pass the
bytes:

```dart
await PRFPdfViewer.show(context, bytes: bytes, title: 'Document');
```

## Removed widgets (no consumers)

These had no usages in the apps and were deleted:

- `ImagePreviewPage` (use `PRFMediaCarousel`)
- `AnimatedStatCard`
- `StatHighlightCard`

## Spacing/radius token values

Token member names are unchanged, but values were normalized onto a 4px grid
(spacing) and a fixed radius scale. Screens using `PRFSpacingTokens` /
`PRFRadiusTokens` / `PRFSizeTokens` keep compiling; margins may shift slightly.
