import 'package:areonix/core/constants/color/color_constants.dart';
import 'package:areonix/core/constants/string/image_constants.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:areonix/views/client/index.dart';
import 'package:areonix/views/dietician/index.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

mixin ChooseViewUIMixin<T extends StatefulWidget> on State<T> {
  final CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  CommonAppbar buildAppBar(BuildContext context) {
    return CommonAppbar(
      title: StringConstants.chooseTitle,
      appbarTextstyle: context.general.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: TColor.airforce,
      ),
    );
  }

  CarouselSlider buildChooseSlider() {
    return CarouselSlider(
      items: [
        CarouselWidget(
          image: ImageConstants.imageMember.toImg,
          title: StringConstants.chooseMember,
          route: const RegisterClientView(),
        ),
        CarouselWidget(
          image: ImageConstants.imageDietician.toImg,
          title: StringConstants.chooseDietician,
          route: const RegisterDieticianView(),
        ),
      ],
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        height: 65.h,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: kIsWeb ? 0.5 : 0.7,
        aspectRatio: 0.7,
      ),
    );
  }
}
