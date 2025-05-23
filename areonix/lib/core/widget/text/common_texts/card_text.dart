import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';

class CardText extends StatelessWidget {
  const CardText({
    required this.text,
    super.key,
    this.color,
  });

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return BoldText(
      text: text,
      color: color,
    );
  }
}
