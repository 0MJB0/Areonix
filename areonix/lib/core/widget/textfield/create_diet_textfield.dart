import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateDietRowTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final void Function(String)? onChanged;
  final double? width;
  final double? height;
  final TextInputType? keyboardType;
  const CreateDietRowTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.width,
    this.hintText,
    this.keyboardType,
    this.height = 10,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textfieldGapPadding = WidgetSize.textfieldGapPadding.value;
    final textfieldWidth = WidgetSize.textfieldWidth.value;
    final textfieldRadius = WidgetSize.textfieldRadius.value;
    return SizedBox(
      width: width!.w,
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        onChanged: onChanged,
        style: context.general.textTheme.bodySmall,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            gapPadding: textfieldGapPadding,
            borderSide: BorderSide(
              color: TColor.airforce,
              width: textfieldWidth,
            ),
            borderRadius: BorderRadius.circular(textfieldRadius),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: textfieldGapPadding,
            borderSide: BorderSide(
              color: TColor.airforce,
              width: textfieldWidth,
            ),
            borderRadius: BorderRadius.circular(textfieldRadius),
          ),
          hintText: hintText,
          hintStyle:
              context.general.textTheme.bodySmall?.copyWith(color: TColor.grey),
          labelText: labelText,
          labelStyle: context.general.textTheme.bodySmall,
          contentPadding: context.padding.low,
        ),
      ),
    );
  }
}
