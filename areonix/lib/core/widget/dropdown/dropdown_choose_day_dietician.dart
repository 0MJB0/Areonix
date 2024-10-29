import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DropdownButtonChooseDay extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final void Function(String?) onChanged;
  final String hintText;
  final double width;
  final TextStyle? hintStyle;
  final String selectedDay;

  const DropdownButtonChooseDay({
    required this.width,
    required this.items,
    required this.onChanged,
    required this.selectedDay,
    this.selectedItem,
    this.hintText = 'Bir seçenek seçiniz',
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    final radius = WidgetSize.dropdownRadius.value;
    final dropdownWidth = WidgetSize.dropdownWidth.value;
    return SizedBox(
      width: width.w,
      child: DropdownSearch<String>(
        items: (filter, infiniteScrollProps) => items,
        onChanged: onChanged,
        selectedItem: selectedDay,
        decoratorProps: DropDownDecoratorProps(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: TColor.airforce,
                width: dropdownWidth,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: TColor.airforce,
                width: dropdownWidth,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: TColor.airforce,
                width: dropdownWidth,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            hintText: 'Diyet Gününüzü Seçiniz',
            hintStyle: context.general.textTheme.titleMedium,
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
              child: DropdownText(
                text: item,
              ),
            );
          },
          constraints: BoxConstraints(
            maxHeight: WidgetSize.dropdownMaxHeight.value.h,
          ),
          menuProps: MenuProps(
            margin: context.padding.onlyTopNormal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
      ),
    );
  }
}
