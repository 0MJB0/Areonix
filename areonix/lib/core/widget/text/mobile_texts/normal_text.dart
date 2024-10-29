import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../constants/index.dart';

class NormalText extends StatelessWidget {
  const NormalText({
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
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: textStyle ??
          context.general.textTheme.labelSmall?.copyWith(
            color: color ?? TColor.grey,
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
    );
  }
}
