import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.color,
    required this.textColor,
    required this.height,
    required this.width,
  }) : super(key: key);
  final VoidCallback  onPressed;
  final String text;
  final Color color;
  final Color textColor;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

        style: ElevatedButton.styleFrom(

          primary: color,
            fixedSize: Size(width, height)// Set the button color here
        ),
        onPressed:onPressed,
        child: Text(text,
            style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.white)
        )
    );/*ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );*/
  }
}

