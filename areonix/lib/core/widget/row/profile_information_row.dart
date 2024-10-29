import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../constants/index.dart';

class ProfileInformationRow extends StatelessWidget {
  final String title;
  final String subtitle;
  const ProfileInformationRow(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.padding.low,
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(WidgetSize.rowRadius.value),
        boxShadow: BoxShadowType.light.boxShadow,
      ),
      child: Column(
        children: [
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: TColor.primaryG,
              ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height));
            },
            child: BoldText(
              text: title,
            ),
          ),
          NormalText(
            text: subtitle,
          ),
        ],
      ),
    );
  }
}
