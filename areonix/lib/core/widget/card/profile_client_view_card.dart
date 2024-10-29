import 'package:areonix/core/enums/index.dart';
import 'package:flutter/material.dart';
import '../../constants/index.dart';
import '../index.dart';

class ProfileClientViewCard extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final bool trailing;
  final VoidCallback onTap;
  final Color? iconColor;

  const ProfileClientViewCard({
    Key? key,
    required this.leadingIcon,
    required this.title,
    this.trailing = false,
    required this.onTap,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(WidgetSize.cardRadius.value),
          boxShadow: BoxShadowType.medium.boxShadow,
        ),
        child: ListTile(
          leading: Icon(
            leadingIcon,
            color: iconColor ?? TColor.airforce,
          ),
          title: BoldText(text: title),
          trailing: Icon(
            Icons.arrow_right,
            color: TColor.airforce,
          ),
        ),
      ),
    );
  }
}
