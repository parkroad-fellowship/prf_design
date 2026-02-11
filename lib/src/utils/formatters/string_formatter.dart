import 'dart:math';

/// String formatting utilities.
class StringFormatter {
  // Private constructor to prevent instantiation
  StringFormatter._();

  /// Get initials from a user name
  static String getUserNameInitials(String userName, {int maxInitials = 2}) {
    final trimmedName = userName.trim();
    if (trimmedName.isEmpty) return 'U';

    final words = trimmedName.split(RegExp(r'\s+'));
    final initials = StringBuffer();

    for (var i = 0; i < min(words.length, maxInitials); i++) {
      if (words[i].isNotEmpty) {
        initials.write(words[i][0].toUpperCase());
      }
    }

    return initials.isEmpty ? 'U' : initials.toString();
  }

  /// Get file name from a path
  static String getFileName(String path) {
    if (path.isEmpty) return '';

    final lastSlashIndex = path.lastIndexOf('/');
    if (lastSlashIndex == -1) return path;

    final fileName = path.substring(lastSlashIndex + 1);
    return fileName.isEmpty ? path : fileName;
  }

  /// Generate random string
  static String generateRandomString(
    int length, {
    bool includeNumbers = true,
    bool includeSymbols = false,
  }) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    const symbols = r'!@#$%^&*';

    var charset = chars;
    if (includeNumbers) charset += numbers;
    if (includeSymbols) charset += symbols;

    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => charset.codeUnitAt(random.nextInt(charset.length)),
      ),
    );
  }
}
