import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import 'mixin/register_client_UI_mixin.dart';
import 'mixin/register_client_mixin.dart';

class RegisterClientView extends ConsumerStatefulWidget {
  const RegisterClientView({super.key});

  @override
  ConsumerState<RegisterClientView> createState() => _RegisterClientViewState();
}

class _RegisterClientViewState extends ConsumerState<RegisterClientView>
    with RegisterClientMixin, RegisterClientUIMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppbar(
        title: StringConstants.registerClientTitle,
      ),
      backgroundColor: TColor.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.sized.dynamicWidth(0.06),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  context.sized.emptySizedHeightBoxLow3x,
                  welcomeTitle(context),
                  context.sized.emptySizedHeightBoxLow3x,
                  textfieldArea(context),
                  context.sized.emptySizedHeightBoxLow3x,
                  signupButton(context),
                  context.sized.emptySizedHeightBoxLow3x,
                  straightLine(),
                  context.sized.emptySizedHeightBoxLow3x,
                  alreadyHaveAccountButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
