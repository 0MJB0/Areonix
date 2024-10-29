import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PersonalClientViewCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData;
  final Widget? trailing;
  final VoidCallback? onTrailingPressed;

  const PersonalClientViewCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.iconData,
    this.trailing,
    this.onTrailingPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kIsWeb ? 50.w : 75.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(WidgetSize.cardRadius.value),
        boxShadow: BoxShadowType.medium.boxShadow,
      ),
      child: ListTile(
        title: kIsWeb
            ? WebText(text: title)
            : BoldText(
                text: title,
                color: TColor.black,
              ),
        subtitle: NormalText(
          text: subtitle,
        ),
        leading: Icon(
          iconData,
          color: TColor.airforce,
        ),
        tileColor: Colors.white,
        trailing: trailing != null
            ? IconButton(
                icon: trailing!,
                onPressed: onTrailingPressed,
              )
            : null,
      ),
    );
  }
}
