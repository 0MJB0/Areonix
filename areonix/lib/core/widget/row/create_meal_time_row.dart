import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CreateMealTimeRow extends StatelessWidget {
  final String dropdownSelectedItem;
  final TextEditingController textTimeController;
  final void Function(String?) onChangedMealTimes;
  final ValueChanged<String>? onChanged;
  CreateMealTimeRow({
    required this.dropdownSelectedItem,
    required this.onChangedMealTimes,
    required this.textTimeController,
    this.onChanged,
  });

  final List<String> _mealTimes = [
    'Kahvaltı',
    'Öğle Yemeği',
    'Akşam Yemeği',
    'Ara Öğün',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CreateDietRowTextField(
          width: 15,
          labelText: 'Zaman',
          hintText: '09:05',
          controller: textTimeController,
          onChanged: onChanged,
        ),
        context.sized.emptySizedWidthBoxLow3x,
        DropdownDietician(
          items: _mealTimes,
          onChanged: onChangedMealTimes,
          selectedItem: dropdownSelectedItem,
          width: 37,
          labelText: 'Öğün',
        ),
      ],
    );
  }
}
