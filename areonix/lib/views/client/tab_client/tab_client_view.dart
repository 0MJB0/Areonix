import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mixin/index.dart';

class TabClientView extends ConsumerStatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const TabClientView({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  _TabClientViewState createState() => _TabClientViewState();
}

class _TabClientViewState extends ConsumerState<TabClientView>
    with TabMemberMixin, TabMemberUIMixin {
  @override
  Widget build(BuildContext context) {
    return buildMemberTabNavigationBar(widget.currentIndex, widget.onTap);
  }
}
