// StateNotifier
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'diet_state.dart';

// Provider
final dietProvider = StateNotifierProvider<DietNotifier, DietState>((ref) {
  return DietNotifier();
});

class DietNotifier extends StateNotifier<DietState> {
  DietNotifier() : super(DietState.initial());

  // Yeni bir öğün ekleme
  void addMeal(String selectedDay) {
    state = state.copyWith(
      mealsByDay: {
        ...state.mealsByDay,
        selectedDay: [...?state.mealsByDay[selectedDay], ''],
      },
      mealControllersByDay: {
        ...state.mealControllersByDay,
        selectedDay: [
          ...?state.mealControllersByDay[selectedDay],
          TextEditingController()
        ],
      },
      mealDetailsByDay: {
        ...state.mealDetailsByDay,
        selectedDay: {...state.mealDetailsByDay[selectedDay] ?? {}, '': []},
      },
      contentControllersByDay: {
        ...state.contentControllersByDay,
        selectedDay: {
          ...state.contentControllersByDay[selectedDay] ?? {},
          '': []
        },
      },
      numberControllersByDay: {
        ...state.numberControllersByDay,
        selectedDay: {
          ...state.numberControllersByDay[selectedDay] ?? {},
          '': []
        },
      },
      mealContentControllersByDay: {
        ...state.mealContentControllersByDay,
        selectedDay: {
          ...state.mealContentControllersByDay[selectedDay] ?? {},
          '': []
        },
      },
      dropdownValueUnitControllersByDay: {
        ...state.dropdownValueUnitControllersByDay,
        selectedDay: {
          ...state.dropdownValueUnitControllersByDay[selectedDay] ?? {},
          '': []
        },
      },
    );
  }

  // Öğünü güncelleme
  void updateMeal(String selectedDay, int mealIndex, String newMealName) {
    final mealName = state.mealsByDay[selectedDay]![mealIndex];
    state = state.copyWith(
      mealsByDay: {
        ...state.mealsByDay,
        selectedDay: List.from(state.mealsByDay[selectedDay]!)
          ..[mealIndex] = newMealName,
      },
      mealDetailsByDay: {
        ...state.mealDetailsByDay,
        selectedDay: {
          ...state.mealDetailsByDay[selectedDay]!,
          newMealName:
              state.mealDetailsByDay[selectedDay]!.remove(mealName) ?? [],
        },
      },
      contentControllersByDay: {
        ...state.contentControllersByDay,
        selectedDay: {
          ...state.contentControllersByDay[selectedDay]!,
          newMealName:
              state.contentControllersByDay[selectedDay]!.remove(mealName) ??
                  [],
        },
      },
      numberControllersByDay: {
        ...state.numberControllersByDay,
        selectedDay: {
          ...state.numberControllersByDay[selectedDay]!,
          newMealName:
              state.numberControllersByDay[selectedDay]!.remove(mealName) ?? [],
        },
      },
      mealContentControllersByDay: {
        ...state.mealContentControllersByDay,
        selectedDay: {
          ...state.mealContentControllersByDay[selectedDay]!,
          newMealName: state.mealContentControllersByDay[selectedDay]!
                  .remove(mealName) ??
              [],
        },
      },
      dropdownValueUnitControllersByDay: {
        ...state.dropdownValueUnitControllersByDay,
        selectedDay: {
          ...state.dropdownValueUnitControllersByDay[selectedDay]!,
          newMealName: state.dropdownValueUnitControllersByDay[selectedDay]!
                  .remove(mealName) ??
              [],
        },
      },
    );
  }

  // Öğünün içeriğini güncelleme
  void updateMealContent(
      String selectedDay, int mealIndex, int contentIndex, String newContent) {
    final mealName = state.mealsByDay[selectedDay]![mealIndex];
    final updatedMealDetails =
        List<String>.from(state.mealDetailsByDay[selectedDay]![mealName]!);
    updatedMealDetails[contentIndex] = newContent;

    state = state.copyWith(
      mealDetailsByDay: {
        ...state.mealDetailsByDay,
        selectedDay: {
          ...state.mealDetailsByDay[selectedDay]!,
          mealName: updatedMealDetails,
        },
      },
    );
  }

  // Yeni içerik ekleme
  void addMealContent(String selectedDay, int mealIndex) {
    final mealName = state.mealsByDay[selectedDay]![mealIndex];
    state = state.copyWith(
      mealDetailsByDay: {
        ...state.mealDetailsByDay,
        selectedDay: {
          ...state.mealDetailsByDay[selectedDay]!,
          mealName: [...state.mealDetailsByDay[selectedDay]![mealName]!, ''],
        },
      },
      contentControllersByDay: {
        ...state.contentControllersByDay,
        selectedDay: {
          ...state.contentControllersByDay[selectedDay]!,
          mealName: [
            ...state.contentControllersByDay[selectedDay]![mealName]!,
            TextEditingController()
          ],
        },
      },
      numberControllersByDay: {
        ...state.numberControllersByDay,
        selectedDay: {
          ...state.numberControllersByDay[selectedDay]!,
          mealName: [
            ...state.numberControllersByDay[selectedDay]![mealName]!,
            TextEditingController()
          ],
        },
      },
      mealContentControllersByDay: {
        ...state.mealContentControllersByDay,
        selectedDay: {
          ...state.mealContentControllersByDay[selectedDay]!,
          mealName: [
            ...state.mealContentControllersByDay[selectedDay]![mealName]!,
            TextEditingController()
          ],
        },
      },
      dropdownValueUnitControllersByDay: {
        ...state.dropdownValueUnitControllersByDay,
        selectedDay: {
          ...state.dropdownValueUnitControllersByDay[selectedDay]!,
          mealName: [
            ...state.dropdownValueUnitControllersByDay[selectedDay]![mealName]!,
            ''
          ],
        },
      },
    );
  }

  // Öğünden bir içerik kaldırma
  void removeMealContent(String selectedDay, int mealIndex, int contentIndex) {
    final mealName = state.mealsByDay[selectedDay]![mealIndex];
    state = state.copyWith(
      mealDetailsByDay: {
        ...state.mealDetailsByDay,
        selectedDay: {
          ...state.mealDetailsByDay[selectedDay]!,
          mealName: List.from(state.mealDetailsByDay[selectedDay]![mealName]!)
            ..removeAt(contentIndex),
        },
      },
      contentControllersByDay: {
        ...state.contentControllersByDay,
        selectedDay: {
          ...state.contentControllersByDay[selectedDay]!,
          mealName:
              List.from(state.contentControllersByDay[selectedDay]![mealName]!)
                ..removeAt(contentIndex),
        },
      },
      numberControllersByDay: {
        ...state.numberControllersByDay,
        selectedDay: {
          ...state.numberControllersByDay[selectedDay]!,
          mealName:
              List.from(state.numberControllersByDay[selectedDay]![mealName]!)
                ..removeAt(contentIndex),
        },
      },
      mealContentControllersByDay: {
        ...state.mealContentControllersByDay,
        selectedDay: {
          ...state.mealContentControllersByDay[selectedDay]!,
          mealName: List.from(
              state.mealContentControllersByDay[selectedDay]![mealName]!)
            ..removeAt(contentIndex),
        },
      },
      dropdownValueUnitControllersByDay: {
        ...state.dropdownValueUnitControllersByDay,
        selectedDay: {
          ...state.dropdownValueUnitControllersByDay[selectedDay]!,
          mealName: List.from(
              state.dropdownValueUnitControllersByDay[selectedDay]![mealName]!)
            ..removeAt(contentIndex),
        },
      },
    );
  }

  // Öğünü kaldırma
  void removeMeal(String selectedDay, int mealIndex) {
    final mealName = state.mealsByDay[selectedDay]![mealIndex];
    state = state.copyWith(
      mealsByDay: {
        ...state.mealsByDay,
        selectedDay: List.from(state.mealsByDay[selectedDay]!)
          ..removeAt(mealIndex),
      },
      mealDetailsByDay: {
        ...state.mealDetailsByDay,
        selectedDay: Map.from(state.mealDetailsByDay[selectedDay]!)
          ..remove(mealName),
      },
      contentControllersByDay: {
        ...state.contentControllersByDay,
        selectedDay: Map.from(state.contentControllersByDay[selectedDay]!)
          ..remove(mealName),
      },
      mealControllersByDay: {
        ...state.mealControllersByDay,
        selectedDay: List.from(state.mealControllersByDay[selectedDay]!)
          ..removeAt(mealIndex),
      },
      numberControllersByDay: {
        ...state.numberControllersByDay,
        selectedDay: Map.from(state.numberControllersByDay[selectedDay]!)
          ..remove(mealName),
      },
      mealContentControllersByDay: {
        ...state.mealContentControllersByDay,
        selectedDay: Map.from(state.mealContentControllersByDay[selectedDay]!)
          ..remove(mealName),
      },
      dropdownValueUnitControllersByDay: {
        ...state.dropdownValueUnitControllersByDay,
        selectedDay:
            Map.from(state.dropdownValueUnitControllersByDay[selectedDay]!)
              ..remove(mealName),
      },
    );
  }

  // DropdownValueUnit güncelleme
  void updateDropdownValueUnit(
      String selectedDay, String mealName, int contentIndex, String newValue) {
    state = state.copyWith(
      dropdownValueUnitControllersByDay: {
        ...state.dropdownValueUnitControllersByDay,
        selectedDay: {
          ...state.dropdownValueUnitControllersByDay[selectedDay]!,
          mealName: List.from(
              state.dropdownValueUnitControllersByDay[selectedDay]![mealName]!)
            ..[contentIndex] = newValue,
        },
      },
    );
  }
}
