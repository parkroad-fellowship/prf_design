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
// Static factory methods
static ThemeData light({
  required double scaleFactor,
  ColorScheme? colorScheme,
  PRFBaseColors? colors,
})
static ThemeData dark({
  required double scaleFactor,
  ColorScheme? colorScheme,
  PRFBaseColors? colors,
})
```

Both methods configure: color scheme, text theme, app bar, buttons, inputs, cards, dividers, tab bar, data table, snackbar, icon, dialog, list tile, chip, and dropdown menu themes.

Omitting both parameters uses the hand-authored PRF palette. Apps with their
own brand have two ways to theme the design system:

1. **Base colours** — pass `PRFBaseColors` (primary/secondary/tertiary/error).
   The theme derives on-colours and container roles from Material 3 tonal
   palettes while keeping PRF's neutral surfaces:

   ```dart
   PRFTheme.light(
     scaleFactor: DeviceHelper.getScaleFactor(context: context),
     colors: const PRFBaseColors(
       primary: myBrandColor,
       secondary: myAccentColor,
     ),
   )
   ```

2. **Full scheme** — pass any Material 3 `ColorScheme` for complete control.
   Every component theme is derived from the supplied scheme (its `brightness`
   selects light or dark typography). This takes precedence over `colors`:

   ```dart
   PRFTheme.light(
     scaleFactor: DeviceHelper.getScaleFactor(context: context),
     colorScheme: myColorScheme,
   )
   ```

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

Typography system using the bundled Manrope family. Fonts ship offline with the
package (declared as Flutter font assets), so no runtime network fetching occurs.

```dart
static TextTheme getLightTheme({required double scaleFactor})
static TextTheme getDarkTheme({required double scaleFactor})
```

Utility text styles:

```dart
PRFTextTheme.getButtonTextStyle(scaleFactor: 1)
```

### PRFAdaptive

The adaptive layer replaces `flutter_adaptive_ui`. Every widget routes to a
device-specific implementation via `PRFAdaptive`, with breakpoints from
`PRFBreakpoints`.

```dart
PRFAdaptive(
  handset: (_) => PRFMyWidgetHandset(...),
  tablet: (_) => PRFMyWidgetTablet(...),
  builder: (_, _) => PRFMyWidgetTablet(...), // fallback
)
```

```dart
PRFBreakpoints.of(context)              // PRFBreakpoint.handset | tablet | desktop
PRFBreakpoints.fromWidth(400)           // handset (<600), tablet (<1024), desktop (>=1024)
PRFBreakpoints.isTabletOrWider(context) // true on tablet/desktop
```

## Widgets

All widgets live under `lib/src/widgets/` and are exported through
`package:prf_design/exports/widgets.dart` (or the main barrel). Every
component reads colours/typography from the current `ThemeData` and respects
adaptive breakpoints via `PRFAdaptive`.

### Buttons

Unified adaptive buttons with a single implementation across device sizes.
Full-width on handset, width-constrained on tablet, press-scale feedback, and a
spinner replacing the label while loading.

#### PRFButton

The single button API. Configure behaviour through `variant`, `disabled` and
`isLoading`.

```dart
PRFButton({
  required VoidCallback onPressed,
  required String title,
  PRFButtonVariant variant = PRFButtonVariant.primary,
  bool disabled = false,
  bool isLoading = false,
})
```

`PRFButtonVariant` is `primary | secondary | destructive | google`.

```dart
PRFButton(
  onPressed: _continue,
  title: 'Continue',
  variant: PRFButtonVariant.primary,
  disabled: false,
  isLoading: _submitting,
)
```

### Inputs

All inputs are adaptive. The unified `PRFTextField` is the only input API; the
`type` parameter selects the behaviour of each variant.

#### PRFTextField

Single adaptive text input implementation for every PRF input variant.

```dart
PRFTextField({
  required String hintText,
  required TextEditingController controller,
  PRFTextFieldType type = PRFTextFieldType.text,
  bool enabled = true,
  bool readOnly = false,
  ValueChanged<String>? onChanged,
  String? labelText,
  String? errorText,
  String? helperText,
  TextInputType? keyboardType,
  TextInputAction textInputAction = TextInputAction.next,
  bool normalizeLeadingCapitalization = true,
  bool isLoading = false,
  String? prefixText,
  int? minLines,
  int? maxLines,
  bool? autocorrect,
  ValueNotifier<bool>? obscureNotifier,
  bool initiallyHidden = true,
})
```

`PRFTextFieldType` is `text | email | name | number | password | textArea`.
Number inputs accept an optional `prefixText` (e.g. `'KES'`); password inputs
obscure the value and expose a visibility toggle driven by `obscureNotifier`.

```dart
PRFTextField(
  hintText: 'Enter amount',
  controller: _amountController,
  type: PRFTextFieldType.number,
  prefixText: 'KES',
  errorText: _amountError,
)
```

#### PRFPhoneInput

International phone input backed by `phone_form_field`, with a draggable
country selector. Validates as a required, valid mobile number.

```dart
PRFPhoneInput({
  required String hintText,
  required PhoneController controller,
  bool enabled = true,
  ValueChanged<PhoneNumber>? onChanged,
  List<IsoCode> countries = const [IsoCode.KE],
})
```

#### PRFFormFieldLabel

Label with an optional required marker.

```dart
PRFFormFieldLabel({
  required String label,
  bool? isRequired,
  Color? color,
  bool? isBold,
})
```

#### PRFFormSection

Groups a form field with an icon, title and optional subtitle.

```dart
PRFFormSection({
  required IconData icon,
  required String title,
  required Widget child,
  bool isRequired = false,
  String? subtitle,
  EdgeInsets? margin,
})
```

```dart
PRFFormSection(
  icon: Icons.person_outline,
  title: 'Contact details',
  subtitle: 'How can the team reach you?',
  child: PRFTextField(hintText: 'Full name', controller: _nameController),
)
```

#### PRFSearchableList\<T\>

Searchable picker with single- and multi-select modes. Works inline on normal
pages (dynamic shrink-wrapped height up to `maxResultHeight`) or modally in
bottom sheets via `showModal`. Pass `selection` for single-select or
`selections` for multi-select.

```dart
PRFSearchableList<T>({
  required List<PRFSearchableListEntry<T>> entries,
  required ValueChanged<T?> onSelected,
  T? selection,
  List<T>? selections,
  String hintText = 'Search',
  String emptyText = 'No results found',
  double maxResultHeight = 240,
  bool isExpanded = false,
  bool autoFocus = false,
})
```

```dart
// Inline on normal page
PRFSearchableList<Team>(
  entries: teams
      .map((t) => PRFSearchableListEntry(value: t, label: t.name))
      .toList(),
  onSelected: (team) => setState(() => _team = team),
  selection: _team,
)

// Modal bottom sheet picker
final selectedTeam = await PRFSearchableList.showModal<Team>(
  context,
  title: 'Select team',
  entries: teams
      .map((t) => PRFSearchableListEntry(value: t, label: t.name))
      .toList(),
  selection: _team,
);
```

`PRFSearchableListEntry<T>` holds a stable `value` and a searchable `label`.

#### PRFReplyComposer

Fixed message-composing bar with a send button, for pinning at the bottom of a
chat screen. The send button activates once `isComposing` is true.

```dart
PRFReplyComposer({
  required TextEditingController controller,
  required String hintText,
  required bool isComposing,
  required bool isLoading,
  required VoidCallback onSend,
  bool enabled = true,
  bool hasFocus = false,
  double bottomInset = 0,
  int minLines = 1,
  int maxLines = 4,
})
```

### State Displays

#### PRFEmptyView

Full-screen empty state with a centred icon, message and optional action.

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

```dart
PRFEmptyView(
  label: 'No missions yet',
  description: 'Tap below to start your first mission.',
  icon: Icons.rocket_launch_outlined,
  actionLabel: 'Create mission',
  onActionPressed: _createMission,
  navBarTitle: 'Missions',
)
```

#### PRFErrorView

Error state with an optional retry button. `compact` renders a smaller inline
variant for lists/cards.

```dart
PRFErrorView({
  required PRFFailure failure,
  VoidCallback? onRetry,
  bool compact = false,
})

// Factories:
PRFErrorView.fromMessage({required String message, VoidCallback? onRetry, bool compact})
PRFErrorView.fromFailure({required PRFFailure failure, VoidCallback? onRetry, bool compact})
```

```dart
PRFErrorView(failure: PRFFailure.noConnection(), onRetry: _reload)
```

#### PRFCategoryChips\<T\>

Horizontally scrollable category chip selector with an optional "ALL" chip.

```dart
PRFCategoryChips<T>({
  required List<T> categories,
  required void Function(T?) onCategorySelected,
  required String Function(T) labelBuilder,
  T? selectedCategory,
  bool isLoading = false,
  bool showAllOption = true,
  String allLabel = 'ALL',
})
```

#### ReplyStatusView

Read/unread reply-status toggle.

```dart
ReplyStatusView({
  required void Function({required bool status}) onStatusSelected,
  required String unreadLabel,
  required String repliedLabel,
  bool reversed = false,
  bool defaultStatus = false,
})
```

#### PRFChatView\<T\>

Full chat screen scaffold: nav bar, scrollable message list rendered via
`messageBuilder`, and a fixed `composer` (e.g. `PRFReplyComposer`).

```dart
PRFChatView<T>({
  required String title,
  required List<T> messages,
  required Widget Function(BuildContext context, T message, int index) messageBuilder,
  required Widget composer,
  VoidCallback? onBack,
  Color? navBarBackgroundColor,
  ScrollController? scrollController,
  bool loading = false,
  String? emptyLabel,
  String? emptyDescription,
  Widget bottomSpacing = const SizedBox(height: PRFSpacingTokens.lg),
})
```

#### PRFSnackbar

Static typed snackbar helpers. Replaces the old `PRFErrorSnackbar`.

```dart
PRFSnackbar.error(context, 'Something went wrong', onRetry: () => _retry());
PRFSnackbar.success(context, 'Saved successfully');
PRFSnackbar.info(context, 'New update available');
PRFSnackbar.warning(context, 'Low storage space');
```

Each method accepts an optional `Duration duration` parameter (default 4s).

### Cards

#### PRFActionCard

Tappable card with an image and title, adaptive to device size.

```dart
PRFActionCard({
  required String title,
  required Widget image,
  VoidCallback? onTap,
})
```

#### PRFDetailActionCard

Tappable detail card with title, subtitle and optional leading/trailing/footer
slots.

```dart
PRFDetailActionCard({
  required String title,
  required String subtitle,
  VoidCallback? onTap,
  Widget? leading,
  Widget? trailing,
  Widget? footer,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  Color? backgroundColor,
})
```

#### PRFInfoCard

Read-only label/value card with a tinted icon tile.

```dart
PRFInfoCard({
  required IconData icon,
  required String label,
  required String value,
})
```

#### PRFMessageBubble

Chat message bubble with timestamp and optional delivery status.

```dart
PRFMessageBubble({
  required String message,
  required String timestamp,
  required bool isIncoming,
  bool showStatusIndicator = false,
  EdgeInsetsGeometry? margin,
  double? maxWidth,
})
```

#### PRFNavigationTile

Tappable card with an SVG illustration and a chevron affordance.

```dart
PRFNavigationTile({
  required String title,
  required String assetPath,
  required VoidCallback onTap,
  double assetHeight = 56,
  bool isNeutralCard = false,
})
```

#### PRFSchoolCard

School list tile with icon, name, address, optional mission count and chevron.

```dart
PRFSchoolCard({
  required String schoolName,
  required String address,
  required VoidCallback onTap,
  int? missionCount,
})
```

#### PRFStatusBadge

Small rounded status pill on a solid colour.

```dart
PRFStatusBadge({
  required String label,
  required Color color,
  EdgeInsetsGeometry? padding,
  BorderRadius? borderRadius,
  TextStyle? textStyle,
  List<BoxShadow>? boxShadow,
})
```

#### PRFTimelineDateBadge

Timeline date badge with an optional connector line; supports single- and
multi-day ranges.

```dart
PRFTimelineDateBadge({
  required DateTime startDate,
  required Color statusColor,
  DateTime? endDate,
  bool isLast = false,
  double connectorHeight = 60,
  double badgeWidth = 50,
})
```

#### PRFTimelineMissionCard

Model-agnostic mission timeline card. All display values are passed as
constructor parameters, so no mission model is required.

```dart
PRFTimelineMissionCard({
  required bool isLast,
  required DateTime startDate,
  required Color statusColor,
  required String statusText,
  required String schoolName,
  required String missionTypeName,
  required String durationLabel,
  required String durationValue,
  required String capacityLabel,
  required String capacityValue,
  required String datePrimaryText,
  required String actionLabel,
  DateTime? endDate,
  String? dateSecondaryText,
  bool showActiveIndicator = false,
  Color? activeIndicatorColor,
  VoidCallback? onTap,
})
```

### Dialogs

#### PRFBottomSheet

Rounded modal bottom sheet with a handle, title, close button and scrollable
body. Stays above the keyboard.

```dart
// Push it:
final result = await PRFBottomSheet.show<Report>(
  context,
  title: 'Generate report',
  heightFactor: 0.7,
  child: ReportForm(onSubmit: (r) => Navigator.pop(context, r)),
);
```

`show` accepts `heightFactor` (default 0.94), `useSafeArea`, `isScrollControlled`,
`isDismissible`, `enableDrag` and `showHandle`.

#### PRFConfirmationDialog

Confirmation dialog with an icon header and confirm/cancel actions. Resolves
`true` when confirmed, `false` when cancelled.

```dart
final confirmed = await PRFConfirmationDialog.show<bool>(
  context,
  title: 'Delete mission?',
  message: 'This action cannot be undone.',
  confirmLabel: 'Delete',
  isDestructive: true,
  onConfirm: _deleteMission,
);
```

### Media

#### PRFMediaCarousel

Full-screen media carousel with swipe navigation, pinch-zoom, and optional
delete/save actions and video pages.

```dart
// Push it:
await PRFMediaCarousel.show(
  context,
  items: [
    PRFCarouselItem(url: photo.url, isVideo: false),
    PRFCarouselItem(url: video.url, isVideo: true),
  ],
  initialIndex: 0,
  onSave: (item) => _download(item.url),
  onDelete: (index) async => await _confirmDelete(),
  videoBuilder: (context, item) => VideoPlayerPage(url: item.url),
);
```

`PRFCarouselItem({required String url, required bool isVideo, String? id})`.

#### PRFMediaGrid

Masonry grid of media tiles (2 columns on handset, 3 on tablet) with an
optional leading "Add Media" tile.

```dart
PRFMediaGrid({
  required int itemCount,
  required Widget Function(BuildContext context, int index) itemBuilder,
  VoidCallback? onAdd,
  String addLabel = 'Add Media',
  IconData addIcon = Icons.add_a_photo_outlined,
})
```

#### PRFMediaTile

Single media tile handling image loading states, video overlays and taps.

```dart
PRFMediaTile({
  required String url,
  bool isVideo = false,
  VoidCallback? onTap,
  Widget Function(BuildContext context, String url)? imageBuilder,
  Widget Function(BuildContext context, String url)? videoThumbnailBuilder,
  double? height,
})
```

### Navigation

#### PRFNavBar

Adaptive top bar with back button, title and actions. Defaults to a sliver
(for `CustomScrollView`); pass `isSliver: false` for a plain bar.

```dart
PRFNavBar({
  required String title,
  VoidCallback? onBack,
  List<Widget>? actions,
  IconData? backIcon,
  Color? backgroundColor,
  bool centerTitle = true,
  bool isSliver = true,
})
```

#### PRFAppBar

Non-sliver variant of `PRFNavBar` for use as `Scaffold.appBar`.

```dart
Scaffold(
  appBar: PRFAppBar(title: 'Profile', onBack: _close),
  body: /* ... */,
)
```

#### PRFBrandedNavBar

Branded app bar with a filled primary background and large title.

```dart
PRFBrandedNavBar({
  required String title,
  VoidCallback? onBack,
  List<Widget>? actions,
  bool showBackButton = true,
  Color? backgroundColor,
  Color? foregroundColor,
})
```

#### PRFDomainTabSection

Titled `TabBar` + `TabBarView` section that fills the remaining vertical space.

```dart
PRFDomainTabSection({
  required String title,
  required String subtitle,
  required List<Widget> tabs,
  required List<Widget> children,
})
```

#### PRFSectionHeader

Bold section heading with an optional subtitle line.

```dart
PRFSectionHeader({
  required String title,
  String? subtitle,
  EdgeInsetsGeometry? padding,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
})
```

### Progress Indicators

#### PRFCircularProgressIndicator

Themed circular spinner, centred in its parent. `value` (0–1) makes it
determinate; null is indeterminate.

```dart
PRFCircularProgressIndicator({
  Color? color,
  double? value,
  double size = 24,
  double strokeWidth = 2,
})
```

#### PRFLinearProgressIndicator

Themed linear progress bar, centred in its parent.

```dart
PRFLinearProgressIndicator({
  Color? color,
  double? value,
  double height = PRFSizeTokens.progressBarHeight,
  double? borderRadius,
  Color? backgroundColor,
})
```

### Indicators

#### WrappedPageIndicator

Animated pill-style page dots (active dot becomes a wide bar).

```dart
WrappedPageIndicator({
  required int currentPage,
  required int pageCount,
})
```

### Viewers

#### PRFPdfViewer

Full-screen PDF viewer. The package performs no network I/O — decode the file
and pass the bytes in. Shows a spinner while opening and an error state with
retry on failure.

```dart
PRFPdfViewer({
  required Uint8List bytes,
  required String title,
  String errorText = 'Failed to open PDF document.',
})

// Push it full-screen:
await PRFPdfViewer.show(context, bytes: bytes, title: 'Document');
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
│   ├── prf_design.dart                # Full library barrel export
│   ├── tokens.dart                    # Standalone design tokens (no widget deps)
│   ├── exports/                       # Granular entry points
│   │   ├── theme.dart                 #   Theme system exports
│   │   ├── widgets.dart               #   Widget exports
│   │   ├── utils.dart                 #   Utility exports
│   │   └── enums.dart                 #   Enum & model exports
│   └── src/
│       ├── enums/                     # Error model
│       │   ├── prf_failure.dart
│       │   ├── prf_error_type.dart
│       │   ├── prf_error_severity.dart
│       │   └── prf_snackbar_type.dart
│       ├── theme/                     # Theming system
│       │   ├── prf_theme.dart         #   ThemeData factories (light/dark)
│       │   ├── text_theme.dart        #   Typography (Manrope/Lato)
│       │   ├── adaptive/              #   PRFAdaptive + PRFBreakpoints
│       │   ├── colors/                #   PRFColors, palette, color utils
│       │   ├── extensions/            #   Theme extension data classes
│       │   └── tokens/                #   Spacing/size/radius/motion/status tokens
│       ├── utils/                     # DeviceHelper, debouncer, formatters
│       └── widgets/                   # Adaptive widgets, one folder per widget
│           ├── buttons/               #   PRFButton (single implementation)
│           ├── inputs/                #   PRFTextField, PRFPhoneInput, searchable list
│           ├── cards/                 #   Action/detail cards, tiles, badges
│           ├── states/                #   Empty/error/reply status views, snackbar
│           ├── media/                 #   Carousel, grid, tiles
│           ├── navigation/            #   Nav bars, tabs, section headers
│           ├── progress/              #   Circular/linear progress indicators
│           ├── indicators/            #   Wrapped page indicator
│           ├── dialogs/               #   Confirmation dialog, bottom sheet
│           └── viewers/               #   PDF viewer
```

Each adaptive widget folder follows the shell + variants pattern:

```
<widget>/
├── <widget>.dart      # Public API shell (PRFAdaptive routing only)
├── _shared.dart       # Pure builder functions + optional shared state
├── _handset.dart      # Handset layout
└── _tablet.dart       # Tablet layout
```

Consolidated widgets (buttons, inputs, PDF viewer) live in a single file that
shares one `_base` implementation instead of the folder split.

## Requirements

| Requirement | Version |
|-------------|---------|
| Dart SDK | `>=3.12.2 <4.0.0` |
| Flutter | `>=3.38.5` |

## Dependencies

| Package | Description |
|---------|-------------|
| `flutter_animate` | Declarative animations |
| `flutter_staggered_grid_view` | Staggered and masonry grid layouts |
| `flutter_svg` | SVG rendering support |
| `intl` | Internationalization and formatting |
| `pdfx` | PDF rendering |
| `phone_form_field` | International phone number input |
| `timezone` | Timezone-aware date/time handling |

The package ships offline: the Manrope typeface is bundled as Flutter font
assets, and removed runtime dependencies (`google_fonts`, `http`,
`flutter_adaptive_ui`) are gone.

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

Publishing to pub.dev is a manual GitHub Actions workflow (`release.yaml`,
triggered via **Run workflow** in the Actions tab) — it publishes the version
declared in `pubspec.yaml`, skipping if the tag already exists.

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