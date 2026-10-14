import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

/// Like `buildSubject`, but with the system text scale forced to [scale].
Widget buildScaledSubject(Widget child, {double scale = 2}) {
  return MaterialApp(
    builder: (context, app) => MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: TextScaler.linear(scale)),
      child: app!,
    ),
    home: Scaffold(
      body: Builder(
        builder: (context) => Theme(
          data: PRFTheme.light(
            scaleFactor: DeviceHelper.getScaleFactor(context: context),
          ),
          child: child,
        ),
      ),
    ),
  );
}

/// Pumps [widget] at 2× text scale and fails on any layout overflow.
Future<void> expectNoOverflowAtLargeText(
  WidgetTester tester,
  Widget widget,
) async {
  await tester.pumpWidget(buildScaledSubject(widget));
  await tester.pumpAndSettle();
  expect(tester.takeException(), isNull);
}
