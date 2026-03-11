import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prf_design/src/theme/extensions/prf_colors_extension.dart';
import 'package:prf_design/src/theme/extensions/prf_status_extension.dart';
import 'package:prf_design/src/theme/prf_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('PRFTheme', () {
    test('light can be built without BuildContext', () {
      final theme = PRFTheme.light();

      expect(theme.useMaterial3, isTrue);
      expect(theme.extensions[PRFColorsExtension], isNotNull);
      expect(theme.extensions[PRFStatusExtension], isNotNull);
    });

    test('dark can be built without BuildContext', () {
      final theme = PRFTheme.dark();

      expect(theme.useMaterial3, isTrue);
      expect(theme.extensions[PRFColorsExtension], isNotNull);
      expect(theme.extensions[PRFStatusExtension], isNotNull);
    });
  });
}
