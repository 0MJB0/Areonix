import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';

class WebAppbarText extends StatelessWidget {
  const WebAppbarText({
    Key? key,
    required this.text,
    this.color,
    this.fontWeight,
    this.textStyle,
    this.textAlign,
  }) : super(key: key);

  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return NormalText(
      text: text,
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}