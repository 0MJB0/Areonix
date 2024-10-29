import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppbar({
    super.key,
    this.title,
    this.color,
    this.leading,
    this.appbarTextstyle,
  });
  final String? title;
  final Color? color;
  final Widget? leading;
  final TextStyle? appbarTextstyle;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColor.red,
        boxShadow: BoxShadowType.medium.boxShadow,
      ),
      child: AppBar(
        leading: leading ??
            (kIsWeb
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {
                      context.route.pop();
                    },
                  )),
        title: kIsWeb
            ? WebAppbarText(
                text: title ?? '',
              )
            : AppbarText(
                text: title ?? '',
              ),
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
