import 'package:areonix/core/widget/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/index.dart';

class CarouselWidget extends StatefulWidget {
  final String image;
  final String title;
  final Widget route;

  const CarouselWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.route,
  }) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.route.navigateToPage(widget.route);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: TColor.primaryG,
          ),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: TColor.black,
            width: 1.h,
          ),
        ),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                widget.image,
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              top: 10,
              left: 15,
              child: kIsWeb
                  ? WebAppbarText(
                      text: widget.title,
                      color: TColor.white,
                    )
                  : BoldText(
                      text: widget.title,
                      color: TColor.white,
                      textStyle: context.general.textTheme.titleLarge,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
