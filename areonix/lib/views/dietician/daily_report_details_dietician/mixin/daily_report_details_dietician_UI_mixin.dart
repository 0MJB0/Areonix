import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/error_constants.dart';
import 'package:areonix/core/widget/card/meal_times_item_card.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // KeyEvent için gerekli
import 'package:kartal/kartal.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'daily_report_details_dietician_mixin.dart';

mixin DailyReportDetailsDieticianUIMixin<T extends StatefulWidget>
    on DailyReportDetailsDieticianMixin<T> {
  final FocusNode _focusNode =
      FocusNode(); // Klavyeden input almak için FocusNode

  @override
  void dispose() {
    _focusNode.dispose(); // FocusNode'u serbest bırak
    super.dispose();
  }

  // Klavyedeki yön tuşları ile sayfa geçişi
  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft &&
          pageController.page!.toInt() > 0) {
        // Sol yön tuşu ile önceki sayfa
        pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight &&
          pageController.page!.toInt() < mealItems.length - 1) {
        // Sağ yön tuşu ile sonraki sayfa
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  // Sağ ve sol ok işaretleri ekleyerek sayfa değiştirme işlevselliği ekleme
  Widget leftArrowButtons(BuildContext context) {
    return Positioned(
      top: context.sized.height * 0.4, // Ortada hizalamak için
      left: 10, // Sol ok işareti
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios,
            color: TColor.airforce, size: 50), // Boyut artırıldı
        onPressed: () {
          if (pageController.page!.toInt() > 0) {
            pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
    );
  }

  Widget rightArrowButton(BuildContext context) {
    return Positioned(
      top: context.sized.height * 0.4, // Ortada hizalamak için
      right: 10, // Sağ ok işareti
      child: IconButton(
        icon: Icon(Icons.arrow_forward_ios,
            color: TColor.airforce, size: 50), // Boyut artırıldı
        onPressed: () {
          if (pageController.page!.toInt() < mealItems.length - 1) {
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
    );
  }

  // HorizontalCardPager yerine SmoothPageIndicator kullanarak senkronizasyon sağlıyoruz
  Widget chooseMealTime(BuildContext context) {
    return Column(
      children: [
        SmoothPageIndicator(
          controller: pageController,
          count: mealItems.length,
          effect: WormEffect(activeDotColor: TColor.airforce),
          onDotClicked: (index) {
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }

  // Meal Details
  Expanded mealDetails(BuildContext context) {
    return Expanded(
      child: KeyboardListener(
        focusNode: _focusNode, // Yön tuşlarını dinlemek için
        autofocus: true, // Sayfa açıldığında otomatik odaklanma
        onKeyEvent: _handleKeyEvent, // Yön tuşu ile tetiklenen fonksiyon
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController, // Ortak controller
              itemCount: mealsList.length,
              onPageChanged: (page) {
                // Sayfa değişiklikleri dinlenebilir
              },
              itemBuilder: (context, index) {
                final selectedMeal = (mealItems[index] as MealTimes).text;
                final downloadUrl = mealsList[index]['downloadUrl'] as String?;

                return LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * (kIsWeb ? 0.3 : 0.1),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BoldText(
                                text: selectedMeal,
                                color: TColor.airforce,
                                textStyle: context.general.textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              ),
                              context.sized.emptySizedHeightBoxLow,
                              if (downloadUrl != null && downloadUrl.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: constraints.maxHeight * 0.02,
                                  ),
                                  child: Container(
                                    width: constraints.maxWidth *
                                        (kIsWeb ? 0.3 : 0.6),
                                    height: constraints.maxHeight * 0.4,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: TColor.black,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.network(
                                      downloadUrl,
                                      fit: BoxFit.fill,
                                      loadingBuilder: (
                                        BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress,
                                      ) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      (loadingProgress
                                                              .expectedTotalBytes ??
                                                          1)
                                                  : null,
                                              color: TColor.airforce,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                )
                              else
                                NormalText(
                                  text:
                                      ErrorConstants.dailyReportDetailsNoImage,
                                  color: TColor.black,
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
            if (kIsWeb) leftArrowButtons(context),
            if (kIsWeb) rightArrowButton(context),
          ],
        ),
      ),
    );
  }

  CommonAppbar appBar(BuildContext context) {
    return CommonAppbar(
      title:
          '${mealsList.isNotEmpty ? mealsList.first["date"] : ErrorConstants.dailyReportDetailsNoDate}',
    );
  }
}
