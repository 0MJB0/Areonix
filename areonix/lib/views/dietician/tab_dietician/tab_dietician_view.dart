import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mixin/index.dart';

class TabDieticianView extends ConsumerStatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const TabDieticianView({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  _TabDieticianViewState createState() => _TabDieticianViewState();
}

class _TabDieticianViewState extends ConsumerState<TabDieticianView>
    with TabDieticianMixin, TabDieticianUIMixin {
  @override
  Widget build(BuildContext context) {
    return buildMemberTabNavigationBar(widget.currentIndex, widget.onTap);
  }
}
