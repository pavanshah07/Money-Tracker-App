import 'package:flutter/material.dart';

import '../globals.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const CustomText(
      {super.key,
        required this.text,
        this.fontSize = 20,
        this.color = textTheme,this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          fontFamily: "Nunito"
      ),
    );
  }
}