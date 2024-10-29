import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class MemberTextField extends StatelessWidget {
  final String description;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Color? color;
  final Color? errorColor;
  final Color? errorTextColor;

  const MemberTextField({
    Key? key,
    required this.description,
    required this.controller,
    this.validator,
    this.color,
    this.errorColor,
    this.errorTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? TColor.airforce;
    final effectiveErrorColor = errorColor ?? Colors.red;
    final effectiveErrorTextColor = errorTextColor ?? Colors.red;
    final borderRadius = WidgetSize.textfieldRadius.value;
    final borderWidth = WidgetSize.textfieldWidth.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoldText(
          text: description,
          textStyle: context.general.textTheme.titleSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        context.sized.emptySizedHeightBoxLow,
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: TColor.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: effectiveColor,
                width: borderWidth,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: effectiveColor,
                width: borderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: effectiveColor,
                width: borderWidth,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide:
                  BorderSide(color: effectiveErrorColor, width: borderWidth),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide:
                  BorderSide(color: effectiveErrorColor, width: borderWidth),
            ),
            errorStyle: TextStyle(
              color: effectiveErrorTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
