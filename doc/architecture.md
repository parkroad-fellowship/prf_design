# prf_design v1.0 — Architecture

This document is the authoritative specification for the `prf_design` package
v1.0 rewrite. It supersedes the historical ad-hoc structure and records the
decisions that the implementation follows.

## 1. Guiding principles

1. **One source of truth per concern.** Raw colors live in `PRFColors` and
   nowhere else. Tokens are the only place magic numbers may exist. A single
   `PRFTheme._build` derives both light and dark themes from one color scheme.
2. **The package is framework, not app.** `prf_design` ships no network calls,
   no hardcoded locale, no product copy. Anything product-specific (Kenya phone
   codes, `http` PDF downloads, "Close"/"Delete" strings) is either removed or
   parameterized.
3. **Consistent adaptive pattern.** Every widget is a thin shell that routes
   through `PRFAdaptive` to `_handset` / `_tablet` variants. No widget embeds
   its own breakpoint logic.
4. **Material 3 as the substrate.** Brand theming is layered on top of
   `ColorScheme`, never as a parallel color system. Widgets read from
   `Theme.of(context)` — never from `PRFColors.*` literals.
5. **Offline by default.** Fonts ship with the package. Widgets never fetch
   at runtime.

## 2. Module layout

```
lib/
  prf_design.dart            Full barrel export
  tokens.dart                Tokens-only barrel (no widget deps)
  exports/                   Granular imports: theme, widgets, utils, enums
  src/
    theme/
      colors/
        prf_colors.dart          ← single source of every raw hex value
        prf_color_palette.dart   ← deprecated facade (removal in next major)
      extensions/
        prf_colors_extension.dart ← slim brand-anchor ThemeExtension
        prf_status_extension.dart  ← status/mission color sets
        theme_context_extensions.dart
      tokens/                    ← PRFSpacing/Radius/Size/Motion/…Tokens
      adaptive/
        prf_breakpoints.dart     ← PRFBreakpoint + PRFBreakpoints
        prf_adaptive.dart        ← PRFAdaptive widget (replaces flutter_adaptive_ui)
      text_theme.dart            ← PRFTextTheme (offline Manrope scale)
      prf_theme.dart             ← PRFTheme.light/dark (single _build)
    enums/                       ← PRFFailure & error model
    utils/                       ← formatters, device helper, debouncer
    widgets/
      <category>/<widget>/
        <widget>.dart            ← PRFAdaptive shell (no layout)
        _shared.dart             ← pure builders + shared state
        _handset.dart            ← handset layout
        _tablet.dart             ← tablet layout
```

## 3. Tokens

- **Spacing** — 4 px grid: `xs=4, sm=8, md=12, lg=16, xl=24, xxl=32, xxxl=40`.
  `lgAlt` removed (was unused). No raw `EdgeInsets.all(n)` in widgets.
- **Radius** — `xs=4, sm=8, smd=12, md=16, lg=20, xl=24, xxl=32, full=999`.
- **Size** — touch targets ≥ `minTouchTarget` (48 dp); icons `iconXs…iconHero`.
- **Motion** — `PRFMotionTokens.resolve(context, duration)` gates every
  animation on reduced-motion; never bare constants.
- Token class names (`PRFSpacingTokens`, `PRFRadiusTokens`, `PRFSizeTokens`,
  `PRFMotionTokens`, `PRFElevationTokens`, `PRFButtonTokens`,
  `PRFStatusTokens`, `PRFShadowTokens`) are kept for consumer continuity.

## 4. Color system

### 4.1 Raw values — `PRFColors`

Defines: brand anchors (`navyBlue`, `limeGreen`), 10-stop navy & lime
palettes, 10-stop gray scale, status colors, and accents. This is the **only**
file containing hex values.

### 4.2 Theme derivation — `PRFTheme`

`PRFTheme.light(scaleFactor:, colorScheme:, colors:)` /
`PRFTheme.dark(scaleFactor:, colorScheme:, colors:)` both call one
`_build(scaleFactor:, scheme:)`. The scheme's brightness selects the typography
and extension variants; all component themes are driven by that scheme. Scheme
resolution: a provided `colorScheme` wins; otherwise `colors:` (`PRFBaseColors`)
seeds a derived scheme (Material 3 tonal palettes for on-colours/containers,
PRF neutrals kept for surfaces); otherwise the hand-authored per-brightness PRF
scheme is used.

| Role | Light | Dark |
| --- | --- | --- |
| primary | navy500 | navy200 |
| onPrimary | white | navy900 |
| primaryContainer | navy50 | navy800 |
| secondary | lime500 | lime400 |
| onSecondary | navy900 | navy900 |
| surface | white | navy900 |
| onSurface | gray900 | gray100 |
| error | error | errorMainDark |

Dark mode no longer *inverts* palette indices — it selects a deliberately
authored dark scheme. Brand anchors (`navyBlue`, `limeGreen`) are identical in
both modes because they are identity, not surfaces.

### 4.3 Extensions

- `PRFColorsExtension` — slim (brand anchors + 4 accents), stable across
  brightness. Replaces the 406-line inverted palette extension.
- `PRFStatusExtension` — semantic status + mission-state color sets, used by
  badges and the snackbar.

### 4.4 Widget rule

Widget layout code reads `theme.colorScheme` / `context.statusColors` /
`context.prfColors`. `PRFColors.*` literals are banned in widget code.

## 5. Typography & fonts

- Offline: Manrope static weights ship under `assets/google_fonts/manrope/`
  and are declared as a Flutter font family in `pubspec.yaml`. Lato remains
  declared as the brand secondary family.
- `PRFTextTheme` builds the scale with `fontFamily: 'Manrope'` — no
  `google_fonts` runtime fetching, no network.
- Hierarchy is strictly decreasing (fixed in v1.0):
  `displayLarge 38 → bodyMedium 15`, with `bodyLarge (16) > bodyMedium (15) >
  bodySmall (13)`.
- `scaleFactor` (from `DeviceHelper`) scales every size.

## 6. Adaptive layer

Replaces `flutter_adaptive_ui`.

- `PRFBreakpoint` — `handset < 600`, `tablet < 1024`, `desktop ≥ 1024`.
- `PRFBreakpoints.of(context)` resolves the current breakpoint.
- `PRFAdaptive` resolves `handset`/`tablet`/`desktop` builders, falling back to
  a default `builder` (tablet) for unhandled sizes:

```dart
PRFAdaptive(
  builder: (_, _) => PRFMyWidgetTablet(...),
  handset: (_) => PRFMyWidgetHandset(...),
  tablet: (_) => PRFMyWidgetTablet(...),
)
```

The dependency on `flutter_adaptive_ui` is removed from `pubspec.yaml`.

## 7. Buttons

One implementation, many faces.

- `PRFButton` — single adaptive implementation with `PRFButtonVariant`
  (`primary`, `secondary`, `destructive`, `google`) and `disabled`/`isLoading`.
- Press feedback is a `Listener`-driven scale (replaces the old
  `GestureDetector` shell) so it never fights the button's own gesture arena.

## 8. Inputs

`PRFTextField` is the single adaptive implementation, typed via
`PRFTextFieldType` (`text`, `email`, `name`, `number`, `password`,
`textArea`). Password visibility is a self-contained suffix toggle.

`PRFPhoneInput` gains a `countries` parameter (defaults to `[IsoCode.KE]`) —
no hardcoded Kenya-only code.

## 9. Productized app widgets

| Widget | v0.8 behavior | v1.0 |
| --- | --- | --- |
| `PRFPdfViewer` | `PDFViewerPage(pdfUrl:)` fetched via `http` | Takes `Uint8List bytes`; no network in package |
| `PRFPhoneInput` | hardcoded `IsoCode.KE` | `countries:` parameter |
| `PRFMediaCarousel` | hardcoded "Close"/"Delete"/"Save to device" copy | Copy parameterized |

`ImagePreviewPage`, `AnimatedStatCard` and `StatHighlightCard` are removed
(no consumers). `assets/authentication/google_logo_loading.svg` is removed
(unused).

## 10. Enforced quality bar

- `PRFMotionTokens.resolve` on every animation duration.
- ≥ 48 dp touch targets; `Tooltip`/`Semantics` on icon-only controls.
- No raw `EdgeInsets`, colors, radii, or icon sizes in widgets.
- `dart analyze --fatal-infos` and `dart format --set-exit-if-changed lib`
  are green in CI.

## 11. Release

- Version bumps to `1.0.0`.
- CI stays format → analyze → test.
- A `Release` workflow runs **only** on `workflow_dispatch` (manual trigger):
  version extraction, tag skip-guard, changelog extraction, pub publish,
  GitHub release.
