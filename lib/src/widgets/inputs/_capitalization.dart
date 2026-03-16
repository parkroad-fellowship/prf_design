import 'package:flutter/services.dart';

class PRFLeadingCapitalizationFormatter extends TextInputFormatter {
  const PRFLeadingCapitalizationFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) {
      return newValue;
    }

    final firstAlphabeticIndex = _findFirstAlphabeticIndex(text);
    if (firstAlphabeticIndex == -1) {
      return newValue;
    }

    final current = text[firstAlphabeticIndex];
    final upper = current.toUpperCase();
    if (current == upper) {
      return newValue;
    }

    final normalized =
        text.substring(0, firstAlphabeticIndex) +
        upper +
        text.substring(firstAlphabeticIndex + 1);

    return newValue.copyWith(text: normalized);
  }

  int _findFirstAlphabeticIndex(String value) {
    for (var i = 0; i < value.length; i++) {
      final char = value[i];
      if (RegExp('[A-Za-z]').hasMatch(char)) {
        return i;
      }
    }
    return -1;
  }
}
