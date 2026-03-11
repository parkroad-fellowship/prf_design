import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/utils/debouncer.dart';

void main() {
  group('Debouncer', () {
    test('executes action after the specified delay', () async {
      final debouncer = Debouncer(milliseconds: 100);
      var executed = false;

      debouncer.run(() => executed = true);

      expect(executed, isFalse);
      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(executed, isTrue);
    });

    test('cancel prevents action from executing', () async {
      final debouncer = Debouncer(milliseconds: 100);
      var executed = false;

      debouncer
        ..run(() => executed = true)
        ..cancel();

      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(executed, isFalse);
    });

    test('cancel sets isPending to false', () {
      final debouncer = Debouncer(milliseconds: 500);

      expect((debouncer..run(() {})).isPending, isTrue);
      expect((debouncer..cancel()).isPending, isFalse);
    });

    test('flush cancels the timer without executing the action', () async {
      final debouncer = Debouncer(milliseconds: 500);
      var executed = false;

      debouncer.run(() => executed = true);
      expect(debouncer.isPending, isTrue);

      debouncer.flush();
      expect(debouncer.isPending, isFalse);

      await Future<void>.delayed(const Duration(milliseconds: 600));
      expect(executed, isFalse);
    });

    test('isPending returns false when no action is scheduled', () {
      final debouncer = Debouncer(milliseconds: 100);
      expect(debouncer.isPending, isFalse);
    });

    test('isPending returns true while action is pending', () {
      final debouncer = Debouncer(milliseconds: 500);

      expect((debouncer..run(() {})).isPending, isTrue);
      debouncer.cancel();
    });

    test('calling run twice resets the timer', () async {
      final debouncer = Debouncer(milliseconds: 200);
      var callCount = 0;

      debouncer.run(() => callCount++);
      await Future<void>.delayed(const Duration(milliseconds: 100));
      debouncer.run(() => callCount++);

      await Future<void>.delayed(const Duration(milliseconds: 300));
      expect(callCount, equals(1));
    });

    test('dispose cancels pending action', () async {
      final debouncer = Debouncer(milliseconds: 100);
      var executed = false;

      debouncer
        ..run(() => executed = true)
        ..dispose();

      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(executed, isFalse);
      expect(debouncer.isPending, isFalse);
    });
  });
}
