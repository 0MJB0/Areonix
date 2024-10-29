import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  final TextStyle? textStyle;
  final List<String> texts;

  const AnimatedText({
    Key? key,
    required this.textStyle,
    required this.texts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DefaultTextStyle(
        style: textStyle!,
        child: AnimatedTextKit(
          repeatForever: false,
          animatedTexts: texts.map(TyperAnimatedText.new).toList(),
        ),
      ),
    );
  }
}
