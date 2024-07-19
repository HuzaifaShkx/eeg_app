import 'package:flutter/material.dart';

class GenderFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;

  const GenderFormField({
    required this.controller,
    required this.hintText,
    required this.labelText,
  });

  @override
  _GenderFormFieldState createState() => _GenderFormFieldState();
}

class _GenderFormFieldState extends State<GenderFormField> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Container(
      width: width-100,
      child:
        DropdownButtonFormField<String>(
          value: _selectedGender,
          hint: Text(widget.hintText),
          onChanged: (String? newValue) {
            setState(() {
              _selectedGender = newValue!;
              widget.controller.text = newValue;
            });
          },
          items: <String>['Male', 'Female']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration:  InputDecoration(
          iconColor: Color(0xFFF5F7FB),
          labelText: widget.labelText,
          hintText: widget.hintText,
         // suffixIcon: widget.icon,
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xFFF5F7FB),width: 2),
          ),
        ),
        ),
    );
  }
}
