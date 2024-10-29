import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ClientInfoCard extends StatelessWidget {
  const ClientInfoCard(
      {super.key,
      required this.message,
      this.icon = Icons.info_outline,
      this.iconColor,
      this.borderColor,
      this.messageColor});
  final String message;
  final IconData icon;
  final Color? iconColor;
  final Color? borderColor;
  final Color? messageColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: context.padding.normal,
        margin: context.padding.horizontalMedium,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(WidgetSize.cardRadius.value),
          boxShadow: BoxShadowType.light.boxShadow,
          border: Border.all(
            color: borderColor ?? TColor.airforce,
            width: WidgetSize.cardBorderWidth.value,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: iconColor ?? TColor.airforce,
              size: WidgetSize.icon.value,
            ),
            context.sized.emptySizedHeightBoxLow,
            BoldText(
              text: message,
              textAlign: TextAlign.center,
              color: messageColor ?? TColor.airforce,
            ),
          ],
        ),
      ),
    );
  }
}
