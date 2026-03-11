import 'dart:async';
import 'dart:ui';

/// A utility class for debouncing function calls.
class Debouncer {
  /// Creates a debouncer with the specified delay in milliseconds.
  Debouncer({required this.milliseconds});

  /// The delay in milliseconds before executing the debounced function.
  final int milliseconds;
  Timer? _timer;
  VoidCallback? _pendingAction;

  /// Executes the action after the debounce delay.
  void run(VoidCallback action) {
    _timer?.cancel();
    _pendingAction = action;
    _timer = Timer(Duration(milliseconds: milliseconds), () {
      _pendingAction = null;
      action();
    });
  }

  /// Cancels any pending debounced action without executing it.
  void cancel() {
    _timer?.cancel();
    _timer = null;
    _pendingAction = null;
  }

  /// Immediately executes any pending action and cancels the timer.
  void flush() {
    final action = _pendingAction;
    cancel();
    action?.call();
  }

  /// Returns true if there's a pending action.
  bool get isPending => _timer != null && _timer!.isActive;

  /// Disposes of the debouncer and cancels any pending actions.
  void dispose() {
    cancel();
  }
}
