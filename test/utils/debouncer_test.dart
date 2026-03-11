import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prf_design/src/utils/debouncer.dart';

void main() {
  group('Debouncer', () {
    test('executes action after the specified delay', () {
      fakeAsync((async) {
        final debouncer = Debouncer(milliseconds: 100);
        var executed = false;

        debouncer.run(() => executed = true);

        expect(executed, isFalse);
        async.elapse(const Duration(milliseconds: 200));
        expect(executed, isTrue);
      });
    });

    test('cancel prevents action from executing', () {
      fakeAsync((async) {
        final debouncer = Debouncer(milliseconds: 100);
        var executed = false;

        debouncer
          ..run(() => executed = true)
          ..cancel();

        async.elapse(const Duration(milliseconds: 200));
        expect(executed, isFalse);
      });
    });

    test('cancel sets isPending to false', () {
      final debouncer = Debouncer(milliseconds: 500);

      expect((debouncer..run(() {})).isPending, isTrue);
      expect((debouncer..cancel()).isPending, isFalse);
    });

    test('flush executes the pending action immediately', () {
      fakeAsync((async) {
        final debouncer = Debouncer(milliseconds: 500);
        var callCount = 0;

        debouncer.run(() => callCount++);
        expect(debouncer.isPending, isTrue);

        debouncer.flush();
        expect(debouncer.isPending, isFalse);
        expect(callCount, equals(1));

        // Ensure the timer doesn't fire again after flush.
        async.elapse(const Duration(milliseconds: 600));
        expect(callCount, equals(1));
      });
    });

    test('flush does nothing when no action is pending', () {
      final debouncer = Debouncer(milliseconds: 500)..flush();
      expect(debouncer.isPending, isFalse);
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

    test('calling run twice resets the timer', () {
      fakeAsync((async) {
        final debouncer = Debouncer(milliseconds: 200);
        var callCount = 0;

        debouncer.run(() => callCount++);
        async.elapse(const Duration(milliseconds: 100));
        debouncer.run(() => callCount++);

        async.elapse(const Duration(milliseconds: 300));
        expect(callCount, equals(1));
      });
    });

    test('dispose cancels pending action', () {
      fakeAsync((async) {
        final debouncer = Debouncer(milliseconds: 100);
        var executed = false;

        debouncer
          ..run(() => executed = true)
          ..dispose();

        async.elapse(const Duration(milliseconds: 200));
        expect(executed, isFalse);
        expect(debouncer.isPending, isFalse);
      });
    });
  });
}
