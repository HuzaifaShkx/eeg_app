import 'package:eeg_app/Custom%20Widget/color.dart';
import 'package:flutter/material.dart';

class LoginMyTextFormField extends StatefulWidget {
  const LoginMyTextFormField({super.key,required this.controller,required this.hintText,required this.labelText, required this.obsecure,
  
  });
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool obsecure;
  

  @override
  State<LoginMyTextFormField> createState() => _LoginMyTextFormFieldState();
}

class _LoginMyTextFormFieldState extends State<LoginMyTextFormField> {
  late bool _ob;
  @override
  void initState() {
    super.initState();
    _ob = widget.obsecure; // Initialize the obscureText based on the passed value
  }
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
          border:Border.all(color: const Color(0xFFF5F7FB),width: 2),
        ),
        child: TextFormField(
           obscureText: _ob,
          controller: widget.controller,
          decoration: InputDecoration(
            iconColor: primary,
            labelText: widget.labelText,
            //hintText: widget.hintText,
            suffixIcon:widget.obsecure? IconButton(
          icon: Icon(
            _ob ? Icons.visibility_off : Icons.visibility,
            color: primary,
          ),
          onPressed: () {
            setState(() {
              _ob = !_ob ; // Toggle obscureText state
            });
          },
        ):null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              //borderSide: BorderSide(color: Color(0xFFF5F7FB),width: 2),
            ),
          ),
        ),
      ),
    );
  }
}