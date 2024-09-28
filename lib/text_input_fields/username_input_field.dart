import 'package:flutter/material.dart';

class UsernameInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon prefixIcon;
  final List<Color> constants;
  // constants[0] = containerBackgroundColor
  // constants[1] = prefixIconColor
  // constants[2] = hintTextColor
  final Color shadowColor;
  final double shadowOpacity;
  final double borderRadius;
  final double widthFactor;

  const UsernameInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.constants,
    this.borderRadius = 10.0,
    this.shadowColor = Colors.grey,
    this.shadowOpacity = 0.3,
    this.widthFactor = 0.85,
  }) : assert(constants.length == 3, 'La lista "constantes" (para el UsernameInputField) debe contener exactamente 3 colores.\n --constants[0] = Color de fondo del contenedor\n --constants[1] = Color del icono prefijo\n --constants[2] = Color del texto de sugerencia');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor, // maximum width
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
          obscureText: false,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            prefixIconColor: constants[1],
            border: InputBorder.none, // Remove the default border
            hintText: hintText,
            hintStyle: TextStyle(color: constants[2], fontWeight: FontWeight.bold),
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16), // Adjust padding
          ),
        ),
      ),
    );
  }
}