/// Types of errors that can occur in the application.
enum PRFErrorType {
  /// Network connectivity issues
  network,

  /// Authentication errors (invalid credentials, expired tokens)
  authentication,

  /// Authorization errors (insufficient permissions)
  authorization,

  /// Input validation errors
  validation,

  /// Resource not found
  notFound,

  /// Server-side errors (5xx)
  server,

  /// Request timeout
  timeout,

  /// Request was cancelled
  cancelled,

  /// Unknown or unclassified error
  unknown,
}
