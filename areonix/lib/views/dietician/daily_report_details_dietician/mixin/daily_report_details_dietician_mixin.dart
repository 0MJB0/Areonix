import 'package:areonix/core/constants/string/responsiveness.dart';
import 'package:areonix/core/widget/card/meal_times_item_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_card_pager/card_item.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

mixin DailyReportDetailsDieticianMixin<T extends StatefulWidget> on State<T> {
  late List<Map<String, dynamic>> mealsList; // Tüm öğünleri alacağız
  late List<String> mealTimes; // Dinamik öğün zamanları
  late List<CardItem> mealItems;
  late PageController pageController;

  final width = kIsWeb
      ? Responsiveness.dailyreportdetailsImageWidthWeb.w
      : Responsiveness.dailyreportdetailsImageWidthMobile.w;
  final height = kIsWeb
      ? Responsiveness.dailyreportdetailsImageHeightWeb.h
      : Responsiveness.dailyreportdetailsImageHeightMobile.h;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pageController = PageController();

    final report = ModalRoute.of(context)?.settings.arguments
        as List<Map<String, dynamic>>?;

    if (report != null && report.isNotEmpty) {
      mealsList = report;
      mealItems = mealsList
          .map((meal) => MealTimes(text: meal['meal'] as String))
          .toList();
    } else {
      mealItems = [];
      mealsList = [];
    }
  }
}
