import 'package:areonix/core/enums/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/index.dart';

class CreateDietMealNameTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String labelText;
  final String? hintText;

  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;

  const CreateDietMealNameTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textfieldRadius = WidgetSize.textfieldRadius.value;
    final borderWidth = WidgetSize.textfieldWidth.value;
    final textfieldGapPadding = WidgetSize.textfieldGapPadding.value;
    return Container(
      width: kIsWeb ? 50.w : 75.w,
      decoration: BoxDecoration(
        color: TColor.grey,
        borderRadius: BorderRadius.circular(textfieldRadius),
      ),
      child: TextFormField(
        cursorColor: TColor.airforce,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        style: context.general.textTheme.labelMedium
            ?.copyWith(fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            gapPadding: textfieldGapPadding,
            borderSide: BorderSide(
              color: TColor.airforce,
              width: borderWidth,
            ),
            borderRadius: BorderRadius.circular(textfieldRadius),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: textfieldGapPadding,
            borderSide: BorderSide(
              color: TColor.airforce,
              width: borderWidth,
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
        validator: validator,
      ),
    );
  }
}
