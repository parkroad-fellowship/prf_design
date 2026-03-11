import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/utils/device_helper.dart';

void main() {
  group('DeviceHelper', () {
    test('returns safe defaults without BuildContext', () {
      expect(DeviceHelper.getScaleFactor(), equals(1));
      expect(DeviceHelper.getDeviceType(), equals(DeviceType.phone));
      expect(DeviceHelper.isLandscape(), isFalse);
    });
  });
}
