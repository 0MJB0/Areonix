import 'package:flutter/material.dart';

// Diyet verilerini tutacak state
class DietState {
  final Map<String, List<String>> mealsByDay;
  final Map<String, List<TextEditingController>> mealControllersByDay;
  final Map<String, Map<String, List<TextEditingController>>>
      contentControllersByDay;
  final Map<String, Map<String, List<String>>> mealDetailsByDay;
  final Map<String, Map<String, List<TextEditingController>>>
      numberControllersByDay;
  final Map<String, Map<String, List<TextEditingController>>>
      mealContentControllersByDay;
  final Map<String, Map<String, List<String>>>
      dropdownValueUnitControllersByDay;

  DietState({
    required this.mealsByDay,
    required this.mealControllersByDay,
    required this.contentControllersByDay,
    required this.mealDetailsByDay,
    required this.numberControllersByDay,
    required this.mealContentControllersByDay,
    required this.dropdownValueUnitControllersByDay,
  });

  // Boş bir başlangıç durumu
  factory DietState.initial() {
    return DietState(
      mealsByDay: {},
      mealControllersByDay: {},
      contentControllersByDay: {},
      mealDetailsByDay: {},
      numberControllersByDay: {},
      mealContentControllersByDay: {},
      dropdownValueUnitControllersByDay: {},
    );
  }

  // Diyet verilerinin güncellenmiş bir kopyasını döndüren metot
  DietState copyWith({
    Map<String, List<String>>? mealsByDay,
    Map<String, List<TextEditingController>>? mealControllersByDay,
    Map<String, Map<String, List<TextEditingController>>>?
        contentControllersByDay,
    Map<String, Map<String, List<String>>>? mealDetailsByDay,
    Map<String, Map<String, List<TextEditingController>>>?
        numberControllersByDay,
    Map<String, Map<String, List<TextEditingController>>>?
        mealContentControllersByDay,
    Map<String, Map<String, List<String>>>? dropdownValueUnitControllersByDay,
  }) {
    return DietState(
      mealsByDay: mealsByDay ?? this.mealsByDay,
      mealControllersByDay: mealControllersByDay ?? this.mealControllersByDay,
      contentControllersByDay:
          contentControllersByDay ?? this.contentControllersByDay,
      mealDetailsByDay: mealDetailsByDay ?? this.mealDetailsByDay,
      numberControllersByDay:
          numberControllersByDay ?? this.numberControllersByDay,
      mealContentControllersByDay:
          mealContentControllersByDay ?? this.mealContentControllersByDay,
      dropdownValueUnitControllersByDay: dropdownValueUnitControllersByDay ??
          this.dropdownValueUnitControllersByDay,
    );
  }
}
