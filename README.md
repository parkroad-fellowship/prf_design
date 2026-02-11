# PRF Design

A reusable Flutter package containing shared widgets, theme system, and essential utilities for PRF applications.

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  prf_design: ^0.1.0
```

Or run:

```bash
flutter pub add prf_design
```

For local development in a monorepo, use a path dependency instead:

```yaml
dependencies:
  prf_design:
    path: packages/prf_design
```

## Usage

### Full Import

```dart
import 'package:prf_design/prf_design.dart';
```

### Granular Imports

```dart
// Theme only
import 'package:prf_design/exports/theme.dart';

// Widgets only
import 'package:prf_design/exports/widgets.dart';

// Utilities only
import 'package:prf_design/exports/utils.dart';

// Models only
import 'package:prf_design/exports/models.dart';
```

## Package Structure

```
prf_design/
├── lib/
│   ├── prf_design.dart      # Main barrel export
│   ├── src/
│   │   ├── models/                 # Error types, failure model
│   │   ├── theme/                  # Colors, text, extensions
│   │   ├── utils/                  # DeviceHelper, formatters, debouncer
│   │   └── widgets/                # All UI components
│   └── exports/                    # Granular exports
```

## Components

### Theme System

- **PRFTheme**: Light and dark theme configurations
- **PRFColors**: Core brand colors (Navy Blue, Lime Green, grays, status colors)
- **PRFColorPalette**: Tints and shades for brand colors
- **PRFColorsExtension**: Theme-aware color access
- **PRFStatusExtension**: Status colors (success, warning, error, etc.)
- **PRFTextTheme**: Typography system using Google Fonts (Lato)

### Widgets

**Buttons:**
- PRFPrimaryButton
- PRFSecondaryButton
- PRFDestroyButton
- GoogleAuthButton

**Inputs:**
- PRFEmailInput
- PRFPasswordInput
- PRFTextInput
- FormFieldLabel

**Progress:**
- PRFCircularProgressIndicator
- PRFLinearProgressIndicator

**States:**
- PRFEmptyView
- PRFErrorView
- PRFErrorSnackbar
- PRFCategoryChips<T>
- ImagePreviewPage
- ReplyStatusView

**Cards:**
- AnimatedStatCard
- StatHighlightCard

**Viewers:**
- PDFViewerPage

**Indicators:**
- WrappedPageIndicator

### Utilities

- **DeviceHelper**: Device type detection, scale factor calculation
- **Debouncer**: Function call debouncing
- **DateFormatter**: Timezone-aware date/time formatting
- **NumberFormatter**: Currency and number formatting
- **StringFormatter**: String manipulation utilities

### Models

- **PRFFailure**: Error handling model
- **PRFErrorType**: Error type enumeration
- **PRFErrorSeverity**: Error severity levels

## Theme Usage Example

```dart
MaterialApp(
  theme: PRFTheme.light(context),
  darkTheme: PRFTheme.dark(context),
  // ...
)
```

## Accessing Theme Extensions

```dart
// Via context extensions
final colors = context.prfColors;
final statusColors = context.statusColors;
final theme = context.theme;
final textTheme = context.textTheme;

// Example usage
Container(
  color: colors.navyBlue,
  child: Text('Success', style: TextStyle(color: statusColors.success.main)),
)
```

## Error Handling Example

```dart
// Show error view
PRFErrorView(
  failure: PRFFailure(message: 'Something went wrong'),
  onRetry: () => _reload(),
)

// Show error snackbar
PRFErrorSnackbar.show(
  context,
  PRFFailure.noConnection(),
  onRetry: () => _retry(),
)
```

## Migrating from App Widgets

If you're migrating from app's existing widgets, use the `FailureAdapter`:

```dart
import 'package:app/utils/adapters/failure_adapter.dart';

// Convert app's Failure to PRFFailure
final prfFailure = failure.toPRFFailure();
PRFErrorView(failure: prfFailure);
```
