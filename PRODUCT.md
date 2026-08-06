# Product

<!-- impeccable:product-schema 1 -->

## Platform

adaptive

## Users

**Fellowship members** — subscribe to missions and enter mission-related data (field reports, sign-ups) on handset and tablet, typically in a church or field context.

**Fellowship leaders** — manage mission configurations, review submitted data, and oversee team activity; use the Leadership app, which demands higher information density and administrative controls.

## Product Purpose

`prf_design` is the shared design system powering the PRF SuperApp suite: **PRF Missions** (member-facing) and **PRF Leadership** (leader-facing). It provides the theme, component library, tokens, utilities, and error models that both apps consume, ensuring visual and behavioural consistency across platforms and app targets.

The apps make it possible for Parkroad Fellowship to run a structured mission programme: members discover and sign up for missions, log field data, and track their contributions; leaders configure, approve, and report on the programme without external tools.

## Positioning

A purpose-built mission management platform for a single fellowship, co-developed and sponsored by FROG Technologies — not a generic church app shell. The design system is versioned and published to pub.dev so it can be consumed cleanly as a dependency.

## Operating Context

- Both apps run on Android and iOS (native Flutter, not a web wrapper).
- Members may use the app in low-connectivity field conditions.
- Leaders use the Leadership app on handset or tablet, often inside church offices or during team reviews.
- Two distinct app-store listings, each with live ratings that must not regress.
- Maintained continuously by FROG Technologies in conjunction with Parkroad Fellowship engineering.

## Capabilities and Constraints

- **Framework**: Flutter >=3.38.5, Dart >=3.12.2, Material 3.
- **Adaptive layout pattern**: every screen is a 4-file structure — shell (`@RoutePage` + `AdaptiveBuilder`), `_shared.dart` (pure builders + shared state class), `_handset.dart`, `_tablet.dart`. This pattern is mandatory for all widget contributions to the design system.
- **Responsive typography**: `DeviceHelper.getScaleFactor(context:)` drives font scaling; do not hard-code text sizes.
- **Tablet layout specifics**: multi-column side-by-side, max button width ~280-320 px centred, 4:3 image aspect ratio, more spacious token usage.
- **Shared state**: use a plain Dart class in `_shared.dart` (not a mixin) to share controllers and logic across variants; each variant owns its own instance lifecycle.
- **Linting**: `very_good_analysis` 10.2.0; CI enforces `--fatal-infos`.

## Brand Commitments

- **Primary colours**: Navy Blue `#1A2253` and Lime Green `#9DE35D` — locked. No substitutions.
- **Typefaces**: Lato (body) and Manrope (display/UI) — bundled as Google Fonts assets; locked.
- **Organisation name**: Parkroad Fellowship.
- **App names**: PRF Missions, PRF Leadership.
- **Homepage**: [parkroadfellowship.org](https://parkroadfellowship.org).

## Evidence on Hand

- Published package: [pub.dev/packages/prf_design](https://pub.dev/packages/prf_design)
- PRF Missions on [Google Play](https://play.google.com/store/apps/details?id=org.parkroadfellowship.app) and [App Store](https://apps.apple.com/us/app/prf-missions/id6746665088)
- PRF Leadership on [Google Play](https://play.google.com/store/apps/details?id=org.parkroadfellowship.leadership) and [App Store](https://apps.apple.com/app/prf-leadership/id6758022193)
- Source: [github.com/PARKROAD-FELLOWSHIP/stunning-fiesta](https://github.com/PARKROAD-FELLOWSHIP/stunning-fiesta)

## Product Principles

1. **Consistency over cleverness** — both apps share one design system; divergence is a bug, not a feature.
2. **Adaptive by default** — every surface ships a handset variant and a tablet variant; neither is an afterthought.
3. **Mission context first** — design decisions serve the field worker and the leader, not generic UX trends.
4. **Stable contracts** — components published to pub.dev carry a versioned public API; breaking changes require intentional version bumps and changelog entries.
5. **Craft at every size** — the design system sets the quality floor; apps built on it should never feel like they assembled off-the-shelf widgets.

## Accessibility & Inclusion

User age range spans 18–90. Design must be modern without sacrificing legibility or ease of use for older members:

- **Contrast**: WCAG AA minimum (4.5:1 for body text, 3:1 for large text and UI components). Prefer AA-Large or better.
- **Touch targets**: minimum 48×48 dp on all interactive elements — no exceptions for secondary actions.
- **Typography**: body text must remain legible at system large-text settings; do not clip or overflow when the user scales up font size.
- **Motion**: respect `MediaQuery.disableAnimations`; all animations must have a reduced-motion fallback.
- **Semantics**: all interactive widgets must carry meaningful `Semantics` labels for screen-reader users.
- **Cognitive load**: favour clear labels, familiar patterns, and short flows over clever interactions — the interface must be immediately learnable without onboarding for the older segment.
