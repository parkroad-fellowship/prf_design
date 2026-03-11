# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`prf_design` is a Flutter design system package providing shared widgets, theming, utilities, and error models. It is published to pub.dev and consumed by the PRF SuperApp.

- **Dart SDK**: >=3.10.3 <4.0.0
- **Flutter**: >=3.38.5
- **Linting**: very_good_analysis 10.2.0 (public_member_api_docs disabled)

## Commands

```bash
# Install dependencies
flutter pub get

# Format and auto-fix
make fmt                              # dart fix --apply && dart format lib test

# Run all tests
make test                             # flutter test

# Run a single test file
flutter test test/path/to/file_test.dart

# Static analysis (CI uses --fatal-infos)
dart analyze --fatal-infos

# Check formatting (CI check)
dart format --set-exit-if-changed lib
```

## Architecture

### Adaptive Widget Pattern

Every UI widget uses `AdaptiveBuilder` from `flutter_adaptive_ui` to provide device-specific implementations:

```
lib/src/widgets/buttons/primary/
  primary.dart      ← Public API: delegates via AdaptiveBuilder
  _handset.dart     ← Phone layout (360x800)
  _tablet.dart      ← Tablet layout (800x600)
```

The public widget (e.g., `PRFPrimaryButton`) accepts all parameters and routes to the correct private variant (`_handset` or `_tablet`) at runtime. Follow this pattern when adding new widgets.

### Export System

- `lib/prf_design.dart` — full library barrel export (re-exports all `_index.dart` files)
- `lib/exports/` — granular imports: `theme.dart`, `widgets.dart`, `utils.dart`, `enums.dart`
- `lib/tokens.dart` — standalone design tokens (no widget dependencies)
- Each module folder has an `_index.dart` that aggregates its exports

### Theme System

- `PRFTheme.light(scaleFactor:)` / `PRFTheme.dark(scaleFactor:)` — Material 3 ThemeData factories
- `PRFColors` — semantic color palettes with light/dark variants
- Theme extensions accessed via `context.prfColors`, `context.statusColors`
- `DeviceHelper.getScaleFactor(context:)` drives responsive typography

### Error Model

`PRFFailure` with factory constructors mapping HTTP status codes to typed errors (`PRFErrorType`, `PRFErrorSeverity`). Uses `copyWith()` for immutability.

## Testing Conventions

- Widget tests use helpers from `test/helpers/button_test_helpers.dart`:
  - `buildSubject(widget)` — wraps in MaterialApp with PRFTheme
  - `setHandsetSize(tester)` / `setTabletSize(tester)` — configure viewport for adaptive testing
- Disable Google Fonts network fetching in tests: `GoogleFonts.config.allowRuntimeFetching = false`
- Timer-based tests use `fake_async`
- Mocking via `mocktail`

## CI Pipeline

On push/PR to `main`: format check → analyze → test (see `.github/workflows/ci.yaml`).
