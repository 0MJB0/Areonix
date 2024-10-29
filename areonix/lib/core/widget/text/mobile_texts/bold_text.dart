import 'package:areonix/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class BoldText extends StatelessWidget {
  const BoldText({
    required this.text,
    super.key,
    this.color,
    this.fontWeight,
    this.textStyle,
    this.textAlign,
  });

  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: textStyle ??
          context.general.textTheme.labelMedium?.copyWith(
            color: color ?? TColor.black,
            fontWeight: fontWeight ?? FontWeight.w700,
          ),
    );
  }
}
