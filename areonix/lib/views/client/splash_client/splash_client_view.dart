import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mixin/splash_client_UI_mixin.dart';
import 'mixin/splash_client_mixin.dart';

class SplashClientView extends ConsumerStatefulWidget {
  @override
  _SplashClientScreenState createState() => _SplashClientScreenState();
}

class _SplashClientScreenState extends ConsumerState<SplashClientView>
    with SplashClientMixin, SplashClientUIMixin {
  @override
  Widget build(BuildContext context) {
    return buildLoadingIndicator();
  }
}
