# PRF Design

[![pub package](https://img.shields.io/pub/v/prf_design.svg)](https://pub.dev/packages/prf_design)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![CI](https://github.com/PARKROAD-FELLOWSHIP/stunning-fiesta/actions/workflows/ci.yaml/badge.svg)](https://github.com/PARKROAD-FELLOWSHIP/stunning-fiesta/actions)

A reusable Flutter package containing shared widgets, theme system, and essential utilities for PRF applications.

## PRF Missions App Links
- [Google Play Store](https://play.google.com/store/apps/details?id=org.parkroadfellowship.app)
- [Apple App Store](https://apps.apple.com/us/app/prf-missions/id6746665088)

## PRF Leadership App Links
- [Google Play Store](https://play.google.com/store/apps/details?id=org.parkroadfellowship.leadership)
- [Apple App Store](https://apps.apple.com/app/prf-leadership/id6758022193)

## Maintenance & Support

- This project is maintained & it's development sponsored by [FROG Technologies](https://frog.ke) in conjunction with Parkroad Fellowship.
- Fellowship website: [Parkroad Fellowship](https://parkroadfellowship.org).
- To get hosting & setup assistance, email `engineering@parkroadfellowship.org` or open an issue on GitHub.

## Community Links

- Fellowship Website: [https://parkroadfellowship.org](https://parkroadfellowship.org)
- Facebook: [https://www.facebook.com/ParkRdFellowship](https://www.facebook.com/ParkRdFellowship)
- Instagram: [https://www.instagram.com/parkroadfellowship](https://www.instagram.com/parkroadfellowship)
- TikTok: [https://www.tiktok.com/@parkroad_fellowship](https://www.tiktok.com/@parkroad_fellowship)
- YouTube: [https://www.youtube.com/@parkroadfellowship](https://www.youtube.com/@parkroadfellowship)


## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  prf_design: ^latest
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

## Quick Start

```dart
import 'package:prf_design/prf_design.dart';

MaterialApp(
  theme: PRFTheme.light(scaleFactor: DeviceHelper.getScaleFactor(context: context)),
  darkTheme: PRFTheme.dark(scaleFactor: DeviceHelper.getScaleFactor(context: context)),
  home: const MyHomePage(),
)
```

## Imports

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

// Enums & error models only
import 'package:prf_design/exports/enums.dart';
```

## Theme System

### PRFTheme

Provides complete Material 3 theme configurations for light and dark modes.

```dart
// Static factory methods (breaking API)
static ThemeData light({required double scaleFactor})
static ThemeData dark({required double scaleFactor})
```

Both methods configure: color scheme, text theme, app bar, buttons, inputs, cards, dividers, tab bar, data table, snackbar, icon, dialog, list tile, chip, and dropdown menu themes.

### PRFColors

Core brand colors and semantic color constants.

**Brand Colors:**

| Color | Hex | Usage |
|-------|-----|-------|
| Navy Blue | `#1A2253` | Primary brand color |
| Lime Green | `#9DE35D` | Secondary brand color |

**Neutral Colors:** `gray50` through `gray900` (10 shades from light to dark)

**Status Colors:** `success`, `successLight`, `successDark`, `warning`, `warningLight`, `warningDark`, `error`, `errorLight`, `errorDark`, `info`, `infoLight`, `infoDark`

**Accent Colors:** `purple` (`#6E4CEB`), `blue` (`#296DFF`), `orange` (`#EB8B2D`), `emerald` (`#12B886`)

**Common Colors:** `white`, `black`, `transparent`

### PRFColorPalette

Tints and shades for brand colors.

- **Navy palette:** `navy50` through `navy900` (10 shades)
- **Lime palette:** `lime50` through `lime900` (10 shades)
- **Convenience getters:** `primary`, `primaryLight`, `primaryContainer`, `primaryDark`, `secondary`, `secondaryLight`, `secondaryContainer`, `secondaryDark`

### PRFColorsExtension

Theme extension for accessing brand colors through the theme system. Includes all palette colors, grays, and accent colors with light/dark variants.

```dart
// Access via context
final colors = context.prfColors;
Container(color: colors.navyBlue)
```

### PRFStatusExtension

Theme extension providing semantic status colors via `StatusColorSet`.

**StatusColorSet:**

```dart
StatusColorSet({
  required Color main,       // Primary status color
  required Color background, // Light background for containers
  required Color onColor,    // Text/icon color on main
})
```

**Standard statuses:** `success`, `warning`, `error`, `info`

**Mission statuses:** `pending` (orange), `initiated` (blue), `scheduled` (orange), `inProgress` (emerald), `completed` (success), `failed` (error), `ignored` (gray)

**Active indicator:** `active`, `activeGlow`

```dart
final status = context.statusColors;
Container(
  color: status.success.background,
  child: Text('Done', style: TextStyle(color: status.success.main)),
)
```

### Context Extensions

Convenience getters on `BuildContext`:

```dart
context.prfColors    // PRFColorsExtension
context.statusColors // PRFStatusExtension
context.colorScheme  // ColorScheme
context.textTheme    // TextTheme
context.theme        // ThemeData
```

### PRFTextTheme

Typography system using Google Fonts (Manrope) with responsive scaling and light/dark variants.

```dart
static TextTheme getLightTheme({required double scaleFactor})
static TextTheme getDarkTheme({required double scaleFactor})
```

Utility text styles:

```dart
PRFTextTheme.getErrorTextStyle(scaleFactor: 1)
PRFTextTheme.getSuccessTextStyle(scaleFactor: 1)
PRFTextTheme.getWarningTextStyle(scaleFactor: 1)
PRFTextTheme.getInfoTextStyle(scaleFactor: 1)
PRFTextTheme.getButtonTextStyle(scaleFactor: 1)
PRFTextTheme.getCaptionTextStyle(scaleFactor: 1)
```

## Widgets

### Buttons

#### PRFPrimaryButton

Adaptive primary button with handset/tablet variants.

```dart
PRFPrimaryButton({
  required VoidCallback onPressed,
  required String title,
  required bool disabled,
  bool? isLoading,
})
```

#### PRFSecondaryButton

Outlined style variant. Same signature as `PRFPrimaryButton`.

#### PRFDestroyButton

Destructive/error style variant. Same signature as `PRFPrimaryButton`.

#### PRFGoogleAuthButton

```dart
PRFGoogleAuthButton({
  required VoidCallback onPressed,
  required String title,
  required bool disabled,
  bool? isLoading,
})
```

### Inputs

All input widgets are responsive with handset/tablet adaptive variants.

#### PRFTextInput

```dart
PRFTextInput({
  required String hintText,
  required TextEditingController controller,
  bool enabled = true,
  bool readOnly = false,
  ValueChanged<String>? onChanged,
  String? labelText,
  String? errorText,
  String? helperText,
  TextInputType? keyboardType,
  TextInputAction textInputAction = TextInputAction.next,
  bool normalizeLeadingCapitalization = true,
})
```

#### PRFEmailInput

```dart
PRFEmailInput({
  required String hintText,
  required TextEditingController emailController,
  bool enabled = true,
})
```

#### PRFPasswordInput

```dart
PRFPasswordInput({
  required String hintText,
  required ValueNotifier<bool> hidePasswordNotifier,
  required TextEditingController passwordController,
  bool enabled = true,
})
```

#### PRFNameInput

```dart
PRFNameInput({
  required String hintText,
  required TextEditingController controller,
  bool enabled = true,
})
```

#### PRFNumberInput

```dart
PRFNumberInput({
  required String hintText,
  required TextEditingController controller,
  bool isLoading = false,
  bool enabled = true,
  String? prefixText,
  String? labelText,
  String? errorText,
  String? helperText,
  ValueChanged<String>? onChanged,
  TextInputAction textInputAction = TextInputAction.next,
})
```

#### PRFTextAreaInput

```dart
PRFTextAreaInput({
  required String hintText,
  required TextEditingController controller,
  bool enabled = true,
  String? labelText,
  String? errorText,
  String? helperText,
  int minLines = 3,
  int maxLines = 5,
  TextInputAction textInputAction = TextInputAction.newline,
  bool normalizeLeadingCapitalization = true,
})
```

#### PRFFormFieldLabel

```dart
PRFFormFieldLabel({
  required String label,
  bool? isRequired,
  Color? color,
  bool? isBold,
})
```

### Progress Indicators

#### PRFCircularProgressIndicator

```dart
PRFCircularProgressIndicator({
  Color? color,
  double? value,
  double size = 24,
  double strokeWidth = 2,
})
```

#### PRFLinearProgressIndicator

```dart
PRFLinearProgressIndicator({
  Color? color,
  double? value,
  double height = 4,
  double? borderRadius,
  Color? backgroundColor,
})
```

### State Displays

#### PRFEmptyView

```dart
PRFEmptyView({
  required String label,
  required String description,
  IconData? icon,
  Widget? action,
  String? actionLabel,
  VoidCallback? onActionPressed,
  String? navBarTitle,
  VoidCallback? onBackPressed,
  bool showBackButton = true,
  List<Widget>? navBarActions,
  Color? navBarBackgroundColor,
  Color? navBarForegroundColor,
})
```

#### PRFErrorView

```dart
PRFErrorView({
  required PRFFailure failure,
  VoidCallback? onRetry,
  bool compact = false,
})

// Factory constructors
PRFErrorView.fromMessage({required String message, VoidCallback? onRetry, bool compact})
PRFErrorView.fromFailure({required PRFFailure failure, VoidCallback? onRetry, bool compact})
```

#### PRFSnackbar

Static methods for typed snackbar notifications. Replaces the old `PRFErrorSnackbar`.

```dart
PRFSnackbar.error(context, 'Something went wrong', onRetry: () => _retry());
PRFSnackbar.success(context, 'Saved successfully');
PRFSnackbar.info(context, 'New update available');
PRFSnackbar.warning(context, 'Low storage space');
```

Each method accepts an optional `Duration duration` parameter.

#### PRFCategoryChips\<T\>

```dart
PRFCategoryChips<T>({
  required List<T> categories,
  required void Function(T?) onCategorySelected,
  required String Function(T) labelBuilder,
  T? selectedCategory,
  bool isLoading = false,
  bool showAllOption = true,
  String allLabel = 'ALL',
  double height = 48,
  double spacing = 10,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16),
})
```

#### ImagePreviewPage

Full-screen image preview with pan/zoom and pagination.

```dart
ImagePreviewPage({
  required List<String> imageUrls,
  required int initialIndex,
  String Function(int index, int total)? titleBuilder,
  String? appBarTitle,
})
```

#### ReplyStatusView

```dart
ReplyStatusView({
  required void Function({required bool status}) onStatusSelected,
  required String unreadLabel,
  required String repliedLabel,
  bool reversed = false,
  bool defaultStatus = false,
})
```

### Cards

#### AnimatedStatCard

```dart
AnimatedStatCard({
  required String value,
  required String label,
  IconData? icon,
  Color? color,
  Duration delay = Duration.zero,
})
```

#### StatHighlightCard

```dart
StatHighlightCard({
  required String title,
  required String subtitle,
  IconData? icon,
  List<Color>? gradient,
  Duration delay = Duration.zero,
})
```

Additional exported cards: `PRFActionCard`, `PRFDetailActionCard`, `PRFInfoCard`, `PRFMessageBubble`, `PRFNavigationTile`, `PRFStatusBadge`, `PRFTimelineDateBadge`, `PRFTimelineMissionCard`.

### Dialogs

Exported: `PRFBottomSheet`, `PRFConfirmationDialog`.

### Media

Exported: `PRFMediaCarousel`, `PRFMediaGrid`, `PRFMediaTile`.

### Navigation

Exported: `PRFBrandedNavBar`, `PRFDomainTabSection`, `PRFNavBar`, `PRFSectionHeader`.

### Additional Inputs

Exported: `PRFPhoneInput`, `PRFSearchableList<T>`, `PRFReplyComposer`, `PRFFormSection`.

### Additional State Widgets

Exported: `PRFChatView<T>`.

### Viewers

#### PDFViewerPage

```dart
PDFViewerPage({
  required String pdfUrl,
  required String title,
})
```

### Indicators

#### WrappedPageIndicator

```dart
WrappedPageIndicator({
  required int currentPage,
  required int pageCount,
})
```

## Utilities

### DeviceHelper

Device type detection and responsive scaling.

```dart
// Get scale factor for responsive sizing
double scale = DeviceHelper.getScaleFactor(
  context: context,
  customBaseWidth: 375,
  minScale: 0.8,
  maxScale: 1.4,
);

// Detect device type
DeviceType type = DeviceHelper.getDeviceType(context: context);
// DeviceType.phone | DeviceType.tablet | DeviceType.desktop

// Check orientation
bool landscape = DeviceHelper.isLandscape(context: context);
```

### Debouncer

```dart
final debouncer = Debouncer(milliseconds: 300);

debouncer.run(() => search(query));
debouncer.cancel();
debouncer.flush();     // Execute pending action immediately
debouncer.isPending;   // Check if action is pending
debouncer.dispose();
```

### DateFormatter

Timezone-aware date/time formatting.

```dart
DateFormatter.formatDateTime(dateTime, 'Africa/Nairobi')       // "Jan 15, 2025, 2:30 PM"
DateFormatter.formatMissionDate(dateTime, 'Africa/Nairobi')    // Mission-specific format
DateFormatter.formatDate(dateTime, 'Africa/Nairobi')           // "Jan 15, 2025"
DateFormatter.timestamp(dateTime, 'Africa/Nairobi')            // Timestamp format
DateFormatter.formatTime('14:30', 'Africa/Nairobi')            // "2:30 PM"
DateFormatter.formatTimeFromDateTime(dateTime, 'Africa/Nairobi')
DateFormatter.getRelativeTime(dateTime)                         // "2 hours ago"
DateFormatter.getMonthAbbreviation(1)                           // "Jan"
```

All methods accept an optional `locale` parameter.

### NumberFormatter

```dart
NumberFormatter.formatCash(1500.50, locale: 'en_KE', symbol: '', decimalDigits: 0, customSymbol: 'KES')
NumberFormatter.truncateToDecimalPlaces(3.14159, 2)  // 3.14
NumberFormatter.roundToDecimalPlaces(3.14159, 2)     // 3.14
NumberFormatter.formatFileSize(1572864)               // "1.5 MB"
```

### StringFormatter

```dart
StringFormatter.getUserNameInitials('John Doe', maxInitials: 2)  // "JD"
StringFormatter.getFileName('/path/to/file.pdf')                  // "file.pdf"
StringFormatter.generateRandomString(16, includeNumbers: true, includeSymbols: false)
```

## Error Handling

### PRFFailure

Comprehensive error model for structured error handling.

```dart
PRFFailure({
  required String message,          // User-friendly message
  int? statusCode,                  // HTTP status code
  PRFErrorType type,                // Error category (default: unknown)
  PRFErrorSeverity severity,        // Severity level (default: medium)
  String? technicalMessage,         // Debug details (not shown to users)
  bool isRecoverable,               // Whether user can retry (default: true)
  StackTrace? stackTrace,
  Map<String, dynamic> context,     // Additional context data
})
```

**Factory constructors:**

```dart
PRFFailure.fromStatusCode(404, 'Not found')
PRFFailure.fromException(error, stackTrace)
PRFFailure.noConnection()
PRFFailure.timeout()
PRFFailure.authentication(message: 'Session expired')
PRFFailure.authorization(message: 'Insufficient permissions')
```

**Methods:**

```dart
failure.copyWith(message: 'Updated message', severity: PRFErrorSeverity.high)
```

### PRFErrorType

`network` | `authentication` | `authorization` | `validation` | `notFound` | `server` | `timeout` | `cancelled` | `unknown`

### PRFErrorSeverity

`low` | `medium` | `high` | `critical`

### PRFSnackbarType

`error` | `success` | `info` | `warning`

### Example: Error Creation & Display

```dart
// Create a failure
final failure = PRFFailure.noConnection();

// Display as error view
PRFErrorView(
  failure: failure,
  onRetry: () => _reload(),
)

// Display as snackbar
PRFSnackbar.error(context, failure.message, onRetry: () => _retry());
```

## Package Structure

```
prf_design/
├── lib/
│   ├── prf_design.dart                # Main barrel export
│   ├── exports/
│   │   ├── theme.dart                 # Theme system exports
│   │   ├── widgets.dart               # Widget exports
│   │   ├── utils.dart                 # Utility exports
│   │   └── enums.dart                 # Enum & model exports
│   └── src/
│       ├── enums/                     # Error types, failure model
│       │   ├── prf_error_type.dart
│       │   ├── prf_error_severity.dart
│       │   ├── prf_snackbar_type.dart
│       │   └── prf_failure.dart
│       ├── theme/                     # Colors, text, extensions
│       │   ├── prf_theme.dart
│       │   ├── text_theme.dart
│       │   ├── colors/
│       │   │   ├── prf_colors.dart
│       │   │   └── prf_color_palette.dart
│       │   └── extensions/
│       │       ├── prf_colors_extension.dart
│       │       ├── prf_status_extension.dart
│       │       └── theme_context_extensions.dart
│       ├── utils/                     # DeviceHelper, formatters, debouncer
│       │   ├── debouncer.dart
│       │   ├── device_helper.dart
│       │   └── formatters/
│       │       ├── date_formatter.dart
│       │       ├── number_formatter.dart
│       │       └── string_formatter.dart
│       └── widgets/                   # All UI components
│           ├── buttons/
│           ├── cards/
│           ├── indicators/
│           ├── inputs/
│           ├── progress/
│           ├── states/
│           └── viewers/
```

## Requirements

| Requirement | Version |
|-------------|---------|
| Dart SDK | `>=3.10.3 <4.0.0` |
| Flutter | `>=3.38.5` |

## Dependencies

| Package | Description |
|---------|-------------|
| `flutter_adaptive_ui` | Responsive handset/tablet layouts |
| `flutter_animate` | Declarative animations |
| `flutter_staggered_grid_view` | Staggered and masonry grid layouts |
| `flutter_svg` | SVG rendering support |
| `google_fonts` | Manrope font and other Google Fonts |
| `http` | HTTP client for network requests |
| `intl` | Internationalization and formatting |
| `pdfx` | PDF rendering |
| `phone_form_field` | International phone number input |
| `timezone` | Timezone-aware date/time handling |

## Contributing

### Development

```bash
# Format code
make fmt

# Run analysis
flutter analyze

# Run tests
flutter test
```

### CI

All pull requests are checked for:
- Code formatting
- Static analysis
- Tests

Publishing to pub.dev is automated via GitHub Actions.

## Open Source Contribution Standards

This repository welcomes contributions. Please review:

- [Contributing Guide](./CONTRIBUTING.md)
- [Code of Conduct](./CODE_OF_CONDUCT.md)
- [Security Policy](./SECURITY.md)
- [Support](./SUPPORT.md)

## License

This project is licensed under [Parkroad Fellowship Public Ministry License 1.0](./LICENSE).

### Allowed

- Use, adapt, and deploy for noncommercial ministry or nonprofit use cases.
- Use by charitable, educational and public-interest organizations.
- Share improvements under the same noncommercial licensing constraints.

### Not allowed

- Selling this software or offering it as a paid commercial product.
- Commercial hosting or commercialization of the software.
- Any use that violates the terms in the [LICENSE](./LICENSE).

For setup and hosting assistance, contact `engineering@parkroadfellowship.org`.