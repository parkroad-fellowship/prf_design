/// Severity levels for errors.
enum PRFErrorSeverity {
  /// Informational, non-blocking issues
  low,

  /// Issues that may affect functionality but are recoverable
  medium,

  /// Significant issues that require attention
  high,

  /// Critical issues that block core functionality
  critical,
}
