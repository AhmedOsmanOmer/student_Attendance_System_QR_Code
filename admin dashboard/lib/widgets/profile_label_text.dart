import 'package:flutter/material.dart';

class ProfileLabelText extends StatelessWidget {
  final bool isBold;
  final String text;
  final double fontSize;
  final Color color;
  const ProfileLabelText({super.key, required this.text, required this.fontSize, required this.color, required this.isBold});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: isBold?FontWeight.bold:FontWeight.normal,
    ),);
  }
}
