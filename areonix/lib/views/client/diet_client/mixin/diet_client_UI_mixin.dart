import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/responsiveness.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:areonix/views/client/diet_client/mixin/diet_client_mixin.dart';
import 'package:card_stack_widget/model/card_model.dart';
import 'package:card_stack_widget/model/card_orientation.dart';
import 'package:card_stack_widget/widget/card_stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

mixin DietClientUIMixin<T extends ConsumerStatefulWidget>
    on DietClientMixin<T> {
  ClientAppbar buildAppBar(BuildContext context) {
    return const ClientAppbar(
      title: StringConstants.dietTitle,
    );
  }

  Widget getSizedBoxBasedOnMealTimesLength(BuildContext context) {
    if (mealTimes.length == 2) {
      return Column(
        children: [
          context.sized.emptySizedHeightBoxHigh,
          context.sized.emptySizedHeightBoxHigh,
        ],
      );
    } else if (mealTimes.length == 3) {
      return context.sized.emptySizedHeightBoxHigh;
    } else if (mealTimes.length == 4) {
      return context.sized.emptySizedHeightBoxHigh;
    } else if (mealTimes.length == 5) {
      return context.sized.emptySizedHeightBoxLow3x;
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget buildCardStackWidget(BuildContext context) {
    if (mealTimes.isEmpty) {
      return const ClientInfoCard(message: StringConstants.dietSplashCardText);
    }

    final mockList = buildMockList(context, size: mealTimes.length);

    return CardStackWidget(
      swipeOrientation: CardOrientation.both,
      cardDismissOrientation: CardOrientation.both,
      positionFactor: 3,
      scaleFactor: 1.5,
      reverseOrder: true,
      animateCardScale: true,
      dismissedCardDuration: const Duration(milliseconds: 300),
      cardList: mockList,
    );
  }

  List<CardModel> buildMockList(BuildContext context, {int size = 0}) {
    final list = <CardModel>[];
    for (var i = 0; i < size; i++) {
      final color = TColor.airforce;

      list.add(
        CardModel(
          backgroundColor: color,
          radius: const Radius.circular(10),
          shadowColor: Colors.black.withOpacity(1),
          child: Stack(
            children: [
              Container(
                width: Responsiveness.dietClientDietCardWidthMobile.w,
                height: Responsiveness.dietClientDietCardHeightMobile.h,
                padding: context.padding.low,
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Responsiveness
                            .dietClientDietCardPlaceholderMobile.h,
                      ),
                      ...mealDetails[mealTimes[i]]?.map(
                            (detail) => Padding(
                              padding: context.padding.verticalLow,
                              child: NormalText(
                                textStyle:
                                    context.general.textTheme.titleMedium,
                                textAlign: TextAlign.left,
                                text: '• $detail',
                                color: TColor.white,
                              ),
                            ),
                          ) ??
                          [],
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: NormalText(
                  text: mealTimes[i],
                  color: TColor.black,
                  textStyle: context.general.textTheme.headlineMedium,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return list;
  }
}
