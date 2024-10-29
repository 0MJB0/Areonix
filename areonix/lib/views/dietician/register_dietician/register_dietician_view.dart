import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import 'mixin/register_dietician_UI_mixin.dart';
import 'mixin/register_dietician_mixin.dart';

class RegisterDieticianView extends ConsumerStatefulWidget {
  const RegisterDieticianView({super.key});

  @override
  ConsumerState<RegisterDieticianView> createState() =>
      _RegisterDieticianViewState();
}

class _RegisterDieticianViewState extends ConsumerState<RegisterDieticianView>
    with RegisterDieticianMixin, RegisterDieticianUIMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        title: StringConstants.registerDieticianTitle,
        color: TColor.airforce,
      ),
      backgroundColor: TColor.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.sized.dynamicWidth(0.05)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  context.sized.emptySizedHeightBoxLow3x,
                  buildWelcomeTitle(context), // Mixin'den gelen metod
                  context.sized.emptySizedHeightBoxLow3x,
                  buildTextfieldArea(context), // Mixin'den gelen metod
                  context.sized.emptySizedHeightBoxLow3x,
                  buildSignupButton(context), // Mixin'den gelen metod
                  context.sized.emptySizedHeightBoxLow3x,
                  straightLine(), // Mixin'den gelen metod
                  context.sized.emptySizedHeightBoxLow3x,
                  buildAlreadyHaveAccountButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
