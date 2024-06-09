import 'dart:developer';

import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  double _oldCurrencyValue = 0;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    log("oldValue: $oldValue");
    log("newValue: $newValue");
    String oldText = oldValue.text;
    String newText = newValue.text;
    int textLengthDifference = newText.length - oldText.length;
    if (textLengthDifference > 0) {
      // TODO (WJ): move to method
      String lastNumericCharacter =
          newText.substring(newText.length - 1).replaceAll(RegExp(r'\D'), '');
      log("lastCharacter $lastNumericCharacter");
      if (lastNumericCharacter.isEmpty) {
        newText = oldText;
      } else {
        int newNumber = int.parse(lastNumericCharacter);
        _oldCurrencyValue = (_oldCurrencyValue * 10) + (newNumber / 100);
        newText = _oldCurrencyValue.toStringAsFixed(2);
      }
    } else if (textLengthDifference < 0) {}

    return newValue.copyWith(
      text: newText,
      selection: TextSelection(
          baseOffset: newText.length, extentOffset: newText.length),
      composing: TextRange.empty,
    );
  }
}
