import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


//textfield that only allows numerical input and formats it into phone number format
//used in register_user()
class PhoneNumberTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final List<Color> constants;
  // constants[0] = containerBackgroundColor
  // constants[1] = prefixIconColor
  // constants[2] = hintTextColor
  // constants[3] = toggleIconColor
  final Color shadowColor;
  final double shadowOpacity;
  final double borderRadius;
  final double widthFactor;

  const PhoneNumberTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.constants,
    this.borderRadius = 10.0,
    this.shadowColor = Colors.grey,
    this.shadowOpacity = 0.3,
    this.widthFactor = 0.85,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: constants[0],
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(shadowOpacity),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.phone, // Use phone number keyboard type
          inputFormatters: [PhoneNumberTextInputFormatter()],
          decoration: InputDecoration(
            border: InputBorder.none,
            // border: const OutlineInputBorder(),
            hintText: hintText,
            hintStyle: TextStyle(color: constants[2], fontWeight: FontWeight.bold),
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.phone, color: constants[1],),
            ),
          ),
        ),
      ),
    );
  }
}

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-numeric characters from the input text
    final cleanText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Format the cleaned text based on its length
    String formattedText = _formatPhoneNumber(cleanText);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return '';
    }

    if (phoneNumber.length <= 5) {
      // Format as 1234-5678 if the length is 4 or less
      return phoneNumber;
    } else {
      // Format as (123) 456-7890 if the length is greater than 4
      final hasParentheses = phoneNumber.length > 9;
      final firstPartLength = hasParentheses ? 3 : 4;
      final firstPart = phoneNumber.substring(0, firstPartLength);
      final secondPart = phoneNumber.substring(firstPartLength);

      return hasParentheses ? '($firstPart) $secondPart' : '$firstPart-$secondPart';
    }
  }
}