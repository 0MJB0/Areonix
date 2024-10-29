import 'package:areonix/core/constants/string/responsiveness.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CreateDietRow extends StatelessWidget {
  final String dropdownValueUnit;
  final TextEditingController textMealController;
  final TextEditingController textNumberController;
  final void Function(String?) onChangedDropdownUnit;
  final ValueChanged<String>? onChanged;
  CreateDietRow({
    required this.dropdownValueUnit,
    required this.onChangedDropdownUnit,
    required this.textMealController,
    required this.textNumberController,
    this.onChanged,
  });

  final List<String> _unitTypesMobile = [
    'Adet',
    'Gram',
    'Kupa',
    'Bardak',
    'Dilim',
    'Porsiyon',
  ]; // Sabit ölçü birimleri

  final List<String> _unitTypesWeb = [
    'Adet',
    'Gram',
    'Kupa',
    'Bardak',
    'Dilim',
    'Porsiyon',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CreateDietRowTextField(
          width: kIsWeb
              ? Responsiveness.createDietRowNumberTextWeb
              : Responsiveness.createDietRowNumberTextMobile,
          labelText: 'Miktar',
          hintText: '',
          controller: textNumberController,
          keyboardType: TextInputType.number,
        ),

        context.sized.emptySizedWidthBoxLow3x,

        DropdownDietician(
          items: kIsWeb ? _unitTypesWeb : _unitTypesMobile,
          onChanged: onChangedDropdownUnit,
          selectedItem: dropdownValueUnit,
          width: kIsWeb
              ? Responsiveness.createDietRowDropdownWeb
              : Responsiveness.createDietRowDropdownMobile,
          labelText: 'Birim',
        ),
        context.sized.emptySizedWidthBoxLow3x,
        // RoundTextFormField
        CreateDietRowTextField(
          width: kIsWeb
              ? Responsiveness.createDietMealCardWeb
              : Responsiveness.createDietRowMealTextMobile,
          labelText: 'Besin',
          controller: textMealController,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
