import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/prf_design.dart';

Widget buildSubject(Widget button) {
  return MaterialApp(
    home: Scaffold(
      body: Builder(
        builder: (context) => Theme(
          data: PRFTheme.light(context),
          child: button,
        ),
      ),
    ),
  );
}

void setHandsetSize(WidgetTester tester) {
  tester.view.physicalSize = const Size(360, 800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void setTabletSize(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}
