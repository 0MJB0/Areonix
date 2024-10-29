import 'package:areonix/core/constants/color/color_constants.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_card_pager/horizontal_card_pager.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/widget/card/meal_times_item_card.dart';
import 'diet_weekly_client_mixin.dart';

mixin DietWeeklyClientUIMixin<T extends ConsumerStatefulWidget>
    on DietWeeklyClientMixin<T> {
  Widget dietComponents(BuildContext context) {
    return mealItems.isEmpty
        ? const ClientInfoCard(message: StringConstants.dietSplashCardText)
        : Column(
            children: [
              context.sized.emptySizedHeightBoxLow,
              chooseDayDropdown(context),
              context.sized.emptySizedHeightBoxNormal,
              chooseMealTime(),
              mealDetails(),
            ],
          );
  }

  Expanded mealDetails() {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        itemCount: mealItems.length,
        itemBuilder: (context, index) {
          final selectedMeal = (mealItems[index] as MealTimes).text;
          final mealContent = diet[selectedDay]?[selectedMeal] ?? [];

          return LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.05,
                  vertical: constraints.maxHeight * 0.2,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: TColor.airforce,
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.04,
                      vertical: constraints.maxHeight * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Öğün başlığı (selectedMeal)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BoldText(
                              text: selectedMeal,
                              color: TColor.black,
                              textStyle: context.general.textTheme.titleLarge,
                            ),
                          ],
                        ),
                        SizedBox(height: constraints.maxHeight * 0.02),

                        // Tablo Başlıkları (Miktar, Birim, Besin)
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(2),
                          },
                          border: const TableBorder(
                            horizontalInside:
                                BorderSide(color: Colors.black12, width: 1),
                            verticalInside:
                                BorderSide(color: Colors.black12, width: 1),
                            top: BorderSide(color: Colors.black12, width: 1),
                            bottom: BorderSide(color: Colors.black12, width: 1),
                            left: BorderSide(color: Colors.black12, width: 1),
                            right: BorderSide(color: Colors.black12, width: 1),
                          ),
                          children: [
                            TableRow(
                              decoration: BoxDecoration(
                                color: TColor.airforce,
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Miktar',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Birim',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Besin',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Tablo İçerikleri (Miktar, Birim, Besin)
                        Expanded(
                          child: ListView.builder(
                            itemCount: mealContent.length,
                            itemBuilder: (context, contentIndex) {
                              // Gelen veriyi ayır (/5/Adet/Elma)
                              final content =
                                  mealContent[contentIndex].split('/');
                              final quantity = content[1]; // Miktar (5)
                              final unit = content[2]; // Birim (Adet)
                              final food = content[3]; // Besin (Elma)

                              return Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(1),
                                  2: FlexColumnWidth(2),
                                },
                                border: const TableBorder(
                                  horizontalInside: BorderSide(
                                      color: Colors.black12, width: 1),
                                  verticalInside: BorderSide(
                                      color: Colors.black12, width: 1),
                                ),
                                children: [
                                  TableRow(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.black12, width: 1),
                                      ),
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          quantity,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          unit,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          food,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget chooseMealTime() {
    return HorizontalCardPager(
      onPageChanged: (page) {
        pageController.animateToPage(
          page.toInt(),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      },
      onSelectedItem: (page) => print("Meal selected: $page"),
      items: mealItems,
    );
  }

  Padding chooseDayDropdown(BuildContext context) {
    final sortedDays = diet.keys.toList();
    sortedDays.sort((a, b) => StringConstants.daysOfWeek
        .indexOf(a)
        .compareTo(StringConstants.daysOfWeek.indexOf(b)));

    return Padding(
      padding: context.padding.onlyTopMedium,
      child: mealItems.isEmpty
          ? const SizedBox.shrink()
          : SizedBox(
              width: 75.w,
              child: DropdownButtonChooseDay(
                items: sortedDays,
                width: 75,
                onChanged: (selected) {
                  setState(() {
                    selectedDay = selected!;
                    // Seçilen güne göre mealItems'ı güncelle
                    mealItems = diet[selectedDay]
                            ?.keys
                            .map((meal) => MealTimes(text: meal))
                            .toList() ??
                        [];

                    // Eğer mealItems boşsa, MemberInfoCard'ı göster, aksi takdirde mealDetails'ı göster.
                    if (mealItems.isEmpty) {
                      const ClientInfoCard(
                          message: StringConstants.dietSplashCardText);
                    }
                  });
                },
                selectedDay: selectedDay,
              ),
            ),
    );
  }
}

ClientAppbar buildAppBar(BuildContext context) {
  return const ClientAppbar(
    title: StringConstants.dietTitle,
  );
}

enum CustomSizes {
  borderRadius(12),
  borderWidth(3),
  maxHeight(15);

  final double value;
  const CustomSizes(this.value);
}
