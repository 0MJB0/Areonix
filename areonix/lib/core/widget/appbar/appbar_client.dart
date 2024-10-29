import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ClientAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ClientAppbar({
    required this.title,
    super.key,
    this.actions,
    this.leading,
  });
  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: BoxShadowType.medium.boxShadow,
      ),
      child: AppBar(
        leading: const SizedBox.shrink(),
        title: BoldText(
          text: title,
          textStyle: context.general.textTheme.titleLarge,
          color: TColor.red,
        ),
        centerTitle: true,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
