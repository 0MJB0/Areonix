import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget buildOptionCard(
  BuildContext context, {
  required String label,
  required VoidCallback onTap,
}) {
  final radius = WidgetSize.cardRadius.value;
  return Padding(
    padding: context.padding.low,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: kIsWeb ? 10.w : 25.w,
        height: kIsWeb ? 10.h : 10.h,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
            child: kIsWeb
                ? WebAppbarText(
                    text: label,
                    textStyle: context.general.textTheme.titleSmall,
                  )
                : CardText(
                    text: label,
                    color: TColor.black,
                  ),
          ),
        ),
      ),
    ),
  );
}
