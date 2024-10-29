import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';

class DropdownText extends StatelessWidget {
  const DropdownText({
    required this.text,
    super.key,
    this.color,
    this.textStyle,
    this.textAlign,
  });

  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return BoldText(
      text: text,
      textAlign: TextAlign.center,
    );
  }
}
