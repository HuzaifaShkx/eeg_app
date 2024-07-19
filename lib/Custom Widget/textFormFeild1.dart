import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({super.key,required this.controller,required this.hintText,required this.labelText,
  
  });
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: width-100,
        height: 50,
        decoration: BoxDecoration(
          
          //color: Color(0xFFF5F7FB),
          //border:Border.all(color: Color(0xFFF5F7FB),width: 2),
        ),
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            iconColor: Color(0xFFF5F7FB),
            labelText: widget.labelText,
            //hintText: widget.hintText,
            
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Color(0xFFF5F7FB),width: 2),
            ),
          ),
        ),
      ),
    );
  }
}