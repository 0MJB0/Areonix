import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class DropdownClient extends StatelessWidget {
  final String description;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;
  final Color? color;

  const DropdownClient({
    Key? key,
    required this.description,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? TColor.airforce;

    final dropdownRadius = WidgetSize.dropdownRadius.value;
    final borderWith = WidgetSize.dropdownWidth.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoldText(
          text: description,
          textStyle: context.general.textTheme.titleSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        context.sized.emptySizedHeightBoxLow,
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(dropdownRadius),
              borderSide: BorderSide(
                color: effectiveColor,
                width: borderWith,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(dropdownRadius),
              borderSide: BorderSide(
                color: effectiveColor,
                width: borderWith,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(dropdownRadius),
              borderSide: BorderSide(
                color: effectiveColor,
                width: borderWith,
              ),
            ),
          ),
          value: value,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
