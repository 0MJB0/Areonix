import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import 'mixin/login_view_UI_mixin.dart';
import 'mixin/login_view_mixin.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView>
    with LoginViewMixin, LoginViewUIMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  context.sized.emptySizedHeightBoxHigh,
                  loginTitle(context),
                  context.sized.emptySizedHeightBoxHigh,
                  loginTextfieldArea(context),
                  context.sized.emptySizedHeightBoxLow3x,
                  loginForgot(context),
                  context.sized.emptySizedHeightBoxNormal,
                  loginButton(context, ref),
                  context.sized.emptySizedHeightBoxNormal,
                  loginLine(),
                  context.sized.emptySizedHeightBoxNormal,
                  loginRegister(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton(BuildContext context, WidgetRef ref) {
    return GradientButton(
      text: StringConstants.loginButton,
      onPressed: () => login(context, ref),
    );
  }
}
