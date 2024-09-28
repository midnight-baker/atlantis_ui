import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ExactRangeDdMmYyyyInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final List<Color> constants;
  // constants[0] = containerBackgroundColor
  // constants[1] = prefixIconColor
  // constants[2] = hintTextColor
  final Color shadowColor;
  final double shadowOpacity;
  final double borderRadius;
  final double widthFactor;
  final List<DateTime> dateRange;

  ExactRangeDdMmYyyyInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.constants,
    this.borderRadius = 10.0,
    this.shadowColor = Colors.grey,
    this.shadowOpacity = 0.3,
    this.widthFactor = 0.85,
    required this.dateRange,
  }) : assert(constants.length == 4, 'La lista "constantes" (para el PasswordInputField) debe contener exactamente 4 colores.\n --constants[0] = Color de fondo del contenedor\n --constants[1] = Color del icono prefijo\n --constants[2] = Color del texto de sugerencia'),
        assert(dateRange.length == 2, 'La lista "yearRange" debe contener exactamente 2 años.'),
        assert(dateRange[0].isBefore(dateRange[1]) || dateRange[0].isAtSameMomentAs(dateRange[1]), 'La primer fecha debe ser anterior o igual a la segunda fecha.');

  @override
  ExactRangeDdMmYyyyInputFieldState createState() => ExactRangeDdMmYyyyInputFieldState();
}


class ExactRangeDdMmYyyyInputFieldState extends State<ExactRangeDdMmYyyyInputField> {
  Timestamp selectedTimestamp = Timestamp.now(); // Initialize with the current timestamp

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widget.widthFactor, // maximum width
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
          readOnly: true,
          controller: widget.controller,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.calendar_today),
            prefixIconColor: widget.constants[1],
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: widget.constants[2], fontWeight: FontWeight.bold),
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = selectedTimestamp.toDate(); // Convert Timestamp to DateTime
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: widget.dateRange[0],
      lastDate: widget.dateRange[1],
    );

    if (picked != null && picked != currentDate) {
      setState(() {
        selectedTimestamp = Timestamp.fromDate(picked); // Convert DateTime back to Timestamp
        widget.controller.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }
}