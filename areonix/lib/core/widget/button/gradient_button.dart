import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final List<Color>? colors;
  final void Function()? onPressed;
  final bool isLoading;

  const GradientButton({
    Key? key,
    required this.text,
    this.colors,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: kIsWeb ? 25.w : 75.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors ?? TColor.primaryG,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(WidgetSize.gradientButton.value),
          boxShadow: BoxShadowType.light.boxShadow,
        ),
        padding: context.padding.normal,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : kIsWeb
                  ? WebText(
                      text: text,
                      textStyle: context.general.textTheme.bodyLarge
                          ?.copyWith(color: TColor.white),
                    )
                  : BoldText(
                      text: text,
                      color: TColor.white,
                    ),
        ),
      ),
    );
  }
}
