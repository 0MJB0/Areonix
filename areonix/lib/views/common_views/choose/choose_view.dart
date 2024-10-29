import 'package:areonix/core/constants/color/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'mixin/index.dart';

class ChooseView extends StatefulWidget {
  const ChooseView({super.key});

  @override
  State<ChooseView> createState() => _ChooseViewState();
}

class _ChooseViewState extends State<ChooseView>
    with ChooseViewMixin, ChooseViewUIMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context), // Mixin'den gelen metod
      backgroundColor: TColor.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            context.sized.emptySizedHeightBoxLow,
            buildChooseSlider(), // Mixin'den gelen metod
            context.sized.emptySizedHeightBoxLow,
          ],
        ),
      ),
    );
  }
}
