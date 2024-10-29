import 'package:areonix/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin SplashClientUIMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  Widget buildLoadingIndicator() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: TColor.airforce,
        ),
      ),
    );
  }
}
