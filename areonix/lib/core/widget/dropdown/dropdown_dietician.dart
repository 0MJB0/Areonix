import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DropdownDietician extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final void Function(String?) onChanged;
  final double width;
  final String? labelText;
  final double? height;

  const DropdownDietician({
    super.key,
    required this.items,
    required this.onChanged,
    required this.width,
    required this.labelText,
    this.selectedItem,
    this.height = 10,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = WidgetSize.dropdownRadius.value;
    return SizedBox(
      width: width.w,
      child: DropdownSearch<String>(
        items: (f, cs) => items,
        onChanged: onChanged,
        selectedItem: selectedItem,
        dropdownBuilder: (context, selectedItem) {
          return NormalText(
            text: selectedItem ?? '',
            textStyle: context.general.textTheme.bodySmall,
            color: TColor.black,
          );
        },
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            fillColor: TColor.white,
            filled: true,
            labelText: labelText,
            labelStyle: context.general.textTheme.labelLarge,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: TColor.airforce,
                width: WidgetSize.dropdownWidth.value,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: TColor.airforce,
                width: WidgetSize.dropdownWidth.value,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: TColor.airforce,
                width: WidgetSize.dropdownWidth.value,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        popupProps: PopupProps.menu(
          scrollbarProps: ScrollbarProps(
            thumbColor: TColor.black,
            thumbVisibility: true,
          ),
          itemBuilder: (context, item, isDisabled, isSelected) {
            return Padding(
              padding: context.padding.verticalLow,
              child: NormalText(
                text: item,
                textAlign: TextAlign.center,
              ),
            );
          },
          constraints:
              BoxConstraints(maxHeight: WidgetSize.dropdownMaxHeight.value.h),
          menuProps: MenuProps(
            margin: context.padding.onlyTopNormal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
