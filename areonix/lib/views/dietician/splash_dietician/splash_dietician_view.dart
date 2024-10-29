import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mixin/splash_dietician_UI_mixin.dart';
import 'mixin/splash_dietician_mixin.dart';

class SplashDieticianView extends ConsumerStatefulWidget {
  @override
  _SplashMemberScreenState createState() => _SplashMemberScreenState();
}

class _SplashMemberScreenState extends ConsumerState<SplashDieticianView>
    with SplashMemberMixin, SplashMemberUIMixin {
  @override
  Widget build(BuildContext context) {
    return buildLoadingIndicator();
  }
}
