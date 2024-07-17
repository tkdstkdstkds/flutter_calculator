import 'package:flutter/services.dart';

class LeadingZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Get the new text
    String newText = newValue.text;

    // Check if the text starts with more than one zero or zero followed by other numbers
    if (newText.startsWith('0')) {
      // Remove leading zeros but keep single zero if it's the only digit
      newText = newText.replaceFirst(RegExp(r'^0+(?=\d)'), '');
    }

    if (newText.isEmpty) {
        newText = '0';
      }

    // Return the new text editing value with the updated text and proper cursor position
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}