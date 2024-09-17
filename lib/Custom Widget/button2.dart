import 'package:flutter/material.dart';

class Button2 extends StatelessWidget {

  const Button2({super.key,required this.text,required this.onTap});
  final String text;
  final VoidCallback onTap;
  
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final double height=50;
    return InkWell(
      onTap: this.onTap,
      child: Container(
        width: width-200,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFF7C0909),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white,width: 2),
          boxShadow:[
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color with 50% opacity
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: Offset(2, 3), // Offset in the X and Y direction
            ),
          ], 
          
        ),
        child: Text(this.text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),textAlign: TextAlign.center,),
      ),
    );
  }
}