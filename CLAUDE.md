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

Every UI widget uses `AdaptiveBuilder` from `flutter_adaptive_ui` to provide device-specific implementations.

Each widget lives in its own folder under `lib/src/widgets/<category>/<widget_name>/`:

```
lib/src/widgets/<category>/<widget_name>/
  <widget_name>.dart   ← Public API shell (AdaptiveBuilder only, no layout)
  _shared.dart         ← Pure builder functions + optional shared state class
  _handset.dart        ← Handset layout (StatelessWidget or StatefulWidget)
  _tablet.dart         ← Tablet layout (StatelessWidget or StatefulWidget)
```

---

## Adding a New Widget

### 1. Shell (`<widget_name>.dart`)

A thin `StatelessWidget`. Declares the public constructor and fields, then routes to the correct variant via `AdaptiveBuilder`. Contains no layout code.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui/flutter_adaptive_ui.dart';
import '_handset.dart';
import '_tablet.dart';

class PRFMyWidget extends StatelessWidget {
  const PRFMyWidget({required this.label, super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      defaultBuilder: (_, __) => PRFMyWidgetTablet(label: label),
      layoutDelegate: AdaptiveLayoutDelegateWithMinimallScreenType(
        handset: (_, __) => PRFMyWidgetHandset(label: label),
        tablet: (_, __) => PRFMyWidgetTablet(label: label),
      ),
    );
  }
}
```

### 2. Shared (`_shared.dart`)

Contains:
- **Pure builder functions** — accept `BuildContext` + explicit params, return a `Widget`. Called by both variants to keep shared sub-components identical.
- **Shared state class** — only when both variants need the same business logic (controllers, navigation methods). Each variant creates and disposes its own instance. Do not use mixins.

```dart
// Pure builder function
Widget buildHeader(BuildContext context, {required ThemeData theme, required String label}) { ... }

// Shared state class (only when needed)
class MyWidgetState {
  MyWidgetState();
  final controller = TextEditingController();
  VoidCallback? _rebuild;
  void attach(VoidCallback rebuild) => _rebuild = rebuild;
  void dispose() { controller.dispose(); _rebuild = null; }
}
```

### 3. Variants (`_handset.dart` / `_tablet.dart`)

Full `StatelessWidget` or `StatefulWidget`. Differ in layout, spacing, and size — not in logic.

| Aspect | Handset | Tablet |
|--------|---------|--------|
| Layout | Single-column vertical stack | Multi-column or side-by-side |
| Max content width | Full-width | `ConstrainedBox(maxWidth: 560–680)` |
| Button width | Full-width with horizontal padding | `ConstrainedBox(maxWidth: 320)`, centred |
| Padding | `PRFSpacingTokens.xl` | `PRFSpacingTokens.xxxl` |
| Icon sizes | `PRFSizeTokens.iconXxxl` | `PRFSizeTokens.iconHero` |

When sharing state, each variant owns its own instance:

```dart
class _HandsetState extends State<PRFMyWidgetHandset> {
  final _state = MyWidgetState();

  @override
  void initState() {
    super.initState();
    _state.attach(() => setState(() {}));
  }

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }
}
```

### 4. Quality checklist before opening a PR

- [ ] **Reduced motion** — every `.animate()` chain and implicit animation duration uses `PRFMotionTokens.resolve(context, duration)`, never a bare constant
- [ ] **Touch targets** — every interactive element is ≥ `PRFSizeTokens.minTouchTarget` (48 dp)
- [ ] **Semantics** — tappable or content-bearing widgets have `Semantics(label:, button:)` or `Tooltip` on icon-only buttons
- [ ] **Spacing tokens** — no raw `EdgeInsets.all(n)`, `SizedBox(height: n)` with magic numbers; use `PRFSpacingTokens`, `PRFSizeTokens`, or `PRFRadiusTokens`
- [ ] **Icon sizes** — use `PRFSizeTokens.icon*` constants, not raw numbers
- [ ] **Colours** — widget layout code uses `theme.colorScheme` or `context.prfColors`; never `PRFColors.*` literals

### 5. Export the widget

Add to `lib/src/widgets/<category>/_index.dart`:

```dart
export '<widget_name>/<widget_name>.dart';
```

### 6. Write tests

Create `test/widgets/<category>/<widget_name>_test.dart`. Cover both viewport sizes and at minimum the primary render and any key interaction:

```dart
void main() {
  setUp(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('renders on handset', (tester) async {
    setHandsetSize(tester);
    await tester.pumpWidget(buildSubject(const PRFMyWidget(label: 'Test')));
    await tester.pumpAndSettle();
    expect(find.text('Test'), findsOneWidget);
  });

  testWidgets('renders on tablet', (tester) async {
    setTabletSize(tester);
    await tester.pumpWidget(buildSubject(const PRFMyWidget(label: 'Test')));
    await tester.pumpAndSettle();
    expect(find.text('Test'), findsOneWidget);
  });
}
```

---

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
