import 'dart:math' hide log;

import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  double _oldCurrencyValue = 0;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String oldText = oldValue.text;
    String newText = newValue.text;
    double? newCurrencyValue = _calculateNewCurrencyValue(oldText, newText);
    if (newCurrencyValue != null) {
      // edge case where _oldCurrencyValue is negative due to floating point arithmetic operations
      _oldCurrencyValue = max(newCurrencyValue, 0);
    }

    newText = _oldCurrencyValue.toStringAsFixed(2);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection(
          baseOffset: newText.length, extentOffset: newText.length),
      composing: TextRange.empty,
    );
  }

  double? _calculateNewCurrencyValue(String oldText, String newText) {
    double? newCurrencyValue;
    int textLengthDifference = newText.length - oldText.length;
    if (textLengthDifference > 0) {
      String lastNumericCharacter =
          newText.substring(newText.length - 1).replaceAll(RegExp(r'\D'), '');
      if (lastNumericCharacter.isNotEmpty) {
        int newNumber = int.parse(lastNumericCharacter);
        newCurrencyValue = (_oldCurrencyValue * 10) + (newNumber / 100);
      }
    } else if (textLengthDifference < 0) {
      String lastNumericCharacter = oldText.substring(oldText.length - 1);
      int newNumber = int.parse(lastNumericCharacter);
      newCurrencyValue = (_oldCurrencyValue - (newNumber / 100)) / 10;
    }
    return newCurrencyValue;
  }
}
