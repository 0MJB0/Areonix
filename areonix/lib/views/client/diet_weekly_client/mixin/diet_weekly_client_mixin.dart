import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/card/meal_times_item_card.dart';
import 'package:areonix/views/client/splash_client/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_card_pager/card_item.dart';

mixin DietWeeklyClientMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  late PageController pageController;

  late String selectedDay;
  late List<CardItem> mealItems;
  late Map<String, Map<String, List<String>>> diet;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    // İlk veri yüklemesi initState içinde yapılır.
    _initializeData();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget güncellendiğinde verileri yeniden yükle
    _initializeData();
  }

  void _initializeData() {
    // Mevcut günü alıyoruz
    final currentDay = getCurrentDay();

    // Riverpod provider'dan veriyi al ve state'i güncelle
    final clientState = ref.read(clientProvider);

    setState(() {
      // selectedDay'i currentDay ile eşitle
      selectedDay = currentDay;

      // Mevcut güne ait öğünleri alıyoruz
      mealItems = clientState.diet?[selectedDay]?.keys
              .map((meal) => MealTimes(text: meal))
              .toList() ??
          [];
      print("mealItems $mealItems");
      // Diet verisini güncelliyoruz
      diet = clientState.diet!;
    });
  }

  String getCurrentDay() {
    // Mevcut günü alıyoruz (0 - Pazartesi, 6 - Pazar)
    final currentDayIndex = DateTime.now().weekday;

    // `weekday` zaten 1 ile başlıyor ve 7'de bitiyor, bu yüzden direkt gün adını döndürebiliriz
    return StringConstants.daysOfWeek[currentDayIndex - 1];
  }
}
