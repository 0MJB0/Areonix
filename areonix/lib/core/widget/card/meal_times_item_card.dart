import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_card_pager/card_item.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MealTimes extends CardItem {
  final String text;
  final Color selectedBgColor;
  final Color noSelectedBgColor;
  final Color selectedIconTextColor;
  final Color selectedTextColor;
  final Color noSelectedIconTextColor;

  MealTimes(
      {required this.text,
      Color? selectedIconTextColor,
      Color? noSelectedIconTextColor,
      Color? selectedBgColor,
      Color? noSelectedBgColor,
      Color? selectedTextColor})
      : selectedIconTextColor = selectedIconTextColor ?? Colors.white,
        selectedTextColor = selectedTextColor ?? TColor.black,
        noSelectedIconTextColor =
            noSelectedIconTextColor ?? const Color(0xFFdddddd),
        selectedBgColor = selectedBgColor ?? TColor.airforce,
        noSelectedBgColor = noSelectedBgColor ?? const Color(0xFFdddddd);

  Widget getIconWidgetBasedOnMeal(String meal) {
    if (meal.toLowerCase().contains('kahvaltı')) {
      return Icon(
        Icons.egg,
        color: selectedIconTextColor,
      ); // Kahvaltı ikonu
    } else if (meal.toLowerCase().contains('ara öğün')) {
      return Icon(
        Icons.free_breakfast,
        color: selectedIconTextColor,
      ); // Ara öğün ikonu
    } else if (meal.toLowerCase().contains('akşam') ||
        meal.toLowerCase().contains('akşam yemeği')) {
      return Icon(
        Icons.dining,
        color: selectedIconTextColor,
      ); // Akşam yemeği ikonu
    } else if (meal.toLowerCase().contains('öğle') ||
        meal.toLowerCase().contains('öğle yemeği')) {
      return Icon(
        Icons.brunch_dining,
        color: selectedIconTextColor,
      ); // Öğle yemeği ikonu
    } else {
      // Default ikon dosyasını Image.asset ile gösteriyoruz
      return Icon(
        Icons.local_dining,
        color: selectedIconTextColor,
      );
    }
  }

  @override
  Widget buildWidget(double diffPosition) {
    // Kartın görünümünü tanımlıyoruz
    double iconOnlyOpacity = 1;
    double iconTextOpacity = 0;

    if (diffPosition < 1) {
      iconOnlyOpacity = diffPosition;
      iconTextOpacity = 1 - diffPosition;
    } else {
      iconOnlyOpacity = 1.0;
      iconTextOpacity = 0;
    }

    // Dinamik olarak ikon veya dosya yolu ile widget'ın seçilmesi
    final selectedIconWidget = getIconWidgetBasedOnMeal(text);

    return Container(
      width: 60.w,
      height: 60.h,
      padding: EdgeInsets.all(WidgetSize.paddingLow.value),
      decoration: BoxDecoration(
        color: diffPosition == 0
            ? selectedBgColor
            : noSelectedBgColor, // Konuma göre renk değişimi
        borderRadius: BorderRadius.circular(WidgetSize.cardBorderWidth.value),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: iconTextOpacity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: selectedIconWidget,
                  ),
                ),
              ],
            ),
          ),
          Opacity(
            opacity: iconOnlyOpacity,
            child: Container(
              padding: EdgeInsets.all(WidgetSize.paddingLow.value),
              child: FittedBox(
                fit: BoxFit.fill,
                child: selectedIconWidget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
