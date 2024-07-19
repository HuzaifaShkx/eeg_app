import 'package:flutter/material.dart';

class MyTextFormField2 extends StatefulWidget {
  const MyTextFormField2({super.key,required this.controller,required this.hintText,required this.labelText,required this.icon
  
  });
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final IconButton icon;

  @override
  State<MyTextFormField2> createState() => _MyTextFormField2State();
}

class _MyTextFormField2State extends State<MyTextFormField2> {
  
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Container(
      width: width-100,
      height: 50,
      decoration: BoxDecoration(
        //color: Color(0xFFF5F7FB),
       // border:Border.all(color: Color(0xFFF5F7FB),width: 2),
      ),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          iconColor: Color(0xFFF5F7FB),
          labelText: widget.labelText,
          //hintText: widget.hintText,
          suffixIcon: widget.icon,
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xFFF5F7FB),width: 2),
          ),
        ),
      ),
    );
  }
}