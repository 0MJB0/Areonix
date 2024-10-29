import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class InformationClientCheckCard extends StatelessWidget {
  const InformationClientCheckCard({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.padding.normal,
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(WidgetSize.cardRadius.value),
        boxShadow: BoxShadowType.medium.boxShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: TColor.airforce,
            size: WidgetSize.icon.value,
          ),
          context.sized.emptySizedHeightBoxLow,
          WebText(
            text: message,
          ),
        ],
      ),
    );
  }
}
