import 'package:flutter/material.dart';


class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon prefixIcon;
  final List<Color> constants;
  // constants[0] = containerBackgroundColor
  // constants[1] = prefixIconColor
  // constants[2] = hintTextColor
  // constants[3] = toggleIconColor
  final Color shadowColor;
  final double shadowOpacity;
  final double borderRadius;
  final double widthFactor;

  const PasswordInputField({super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.constants,
    this.borderRadius = 10.0,
    this.shadowColor = Colors.grey,
    this.shadowOpacity = 0.3,
    this.widthFactor = 0.85,
  }) : assert(constants.length == 4, 'La lista "constantes" (para el PasswordInputField) debe contener exactamente 4 colores.\n --constants[0] = Color de fondo del contenedor\n --constants[1] = Color del icono prefijo\n --constants[2] = Color del texto de sugerencia\n --constants[3] = Color del icono sufijo');

  @override
  PasswordInputFieldState createState() => PasswordInputFieldState();
}



class PasswordInputFieldState extends State<PasswordInputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widget.widthFactor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: widget.constants[0],
          boxShadow: [
            BoxShadow(
              color: widget.shadowColor.withOpacity(widget.shadowOpacity),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            prefixIconColor: widget.constants[1],
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: widget.constants[2], fontWeight: FontWeight.bold),
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: widget.constants[3],
              ),
            ),
          ),
        ),
      ),
    );
  }
}