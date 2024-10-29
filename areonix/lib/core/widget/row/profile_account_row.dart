import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ProfileAccountRow extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;
  const ProfileAccountRow(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Image.asset(
            icon,
            height: WidgetSize.rowImageHeight.value,
            width: WidgetSize.rowImageWidth.value,
            fit: BoxFit.contain,
          ),
          context.sized.emptySizedHeightBoxLow,
          Expanded(
            child: NormalText(
              text: title,
            ),
          ),
          const Icon(Icons.navigate_next),
        ],
      ),
    );
  }
}
