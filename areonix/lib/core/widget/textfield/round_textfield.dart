import 'package:areonix/core/enums/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/index.dart';

class RoundTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String labelText;
  final IconData icon;
  final Color? iconColor;
  final Widget? rightIcon;
  final bool? secureText;
  final EdgeInsets? margin;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;

  const RoundTextFormField({
    super.key,
    required this.labelText,
    required this.icon,
    this.iconColor,
    this.controller,
    this.margin,
    this.keyboardType,
    this.secureText = false,
    this.rightIcon,
    this.inputFormatters,
    this.validator,
    this.textInputAction = TextInputAction.next, // Varsayılan olarak "next"
    this.onChanged, // onChanged fonksiyonu için parametre eklendi
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = WidgetSize.textfieldRadius.value;
    const width = 20.0;
    const height = 20.0;
    return Container(
      width: kIsWeb ? 50.w : 75.w,
      margin: margin,
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextFormField(
        cursorColor: TColor.airforce,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: secureText ?? false,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        onChanged: onChanged,
        style: context.general.textTheme.labelMedium
            ?.copyWith(fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          fillColor: TColor.white,
          contentPadding: context.padding.normal,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: TColor.grey.withOpacity(0.7)),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: TColor.airforce,
              width: 2,
            ), // Kenar rengi ve kalınlığı
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          labelText: labelText,
          labelStyle: context.general.textTheme.bodyMedium,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: rightIcon,
          prefixIcon: Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            child: Icon(
              icon,
              size: WidgetSize.icon.value,
              color: iconColor ?? TColor.airforce,
            ),
          ),
          hintStyle: TextStyle(color: TColor.grey, fontSize: 12),
        ),
        validator: validator,
      ),
    );
  }
}
