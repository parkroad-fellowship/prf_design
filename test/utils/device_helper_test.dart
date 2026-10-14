import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/theme/adaptive/prf_breakpoints.dart';
import 'package:prf_design/src/utils/device_helper.dart';

Future<T> _withWidth<T>(
  WidgetTester tester,
  double width,
  T Function(BuildContext context) read,
) async {
  late T result;
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(size: Size(width, 800)),
      child: Builder(
        builder: (context) {
          result = read(context);
          return const SizedBox();
        },
      ),
    ),
  );
  return result;
}

void main() {
  group('DeviceHelper', () {
    test('returns safe defaults without BuildContext', () {
      expect(DeviceHelper.getScaleFactor(), equals(1));
      expect(DeviceHelper.getDeviceType(), equals(DeviceType.phone));
      expect(DeviceHelper.isLandscape(), isFalse);
    });

    testWidgets('device type follows PRFBreakpoints', (tester) async {
      Future<DeviceType> typeAt(double w) =>
          _withWidth(tester, w, (c) => DeviceHelper.getDeviceType(context: c));
      expect(await typeAt(PRFBreakpoints.tabletMin - 1), DeviceType.phone);
      expect(await typeAt(PRFBreakpoints.tabletMin), DeviceType.tablet);
      expect(await typeAt(PRFBreakpoints.desktopMin - 1), DeviceType.tablet);
      expect(await typeAt(PRFBreakpoints.desktopMin), DeviceType.desktop);
    });

    testWidgets('narrow phones keep labelSmall at 11sp or larger', (
      tester,
    ) async {
      final scale = await _withWidth(
        tester,
        320,
        (c) => DeviceHelper.getScaleFactor(context: c),
      );
      // labelSmall base size is 12sp.
      expect(12 * scale, greaterThanOrEqualTo(11));
    });

    // Phone (max 1.4x by 525dp) -> tablet (1.0x at 600dp) still steps down;
    // that is pre-existing and changing it resizes every tablet screen.
    testWidgets('text never shrinks from tablet to desktop', (tester) async {
      var previous = 0.0;
      for (var width = PRFBreakpoints.tabletMin; width <= 1600; width += 8) {
        final scale = await _withWidth(
          tester,
          width,
          (c) => DeviceHelper.getScaleFactor(context: c),
        );
        expect(
          scale,
          greaterThanOrEqualTo(previous),
          reason: 'scale dropped at ${width}dp',
        );
        previous = scale;
      }
    });
  });
}
