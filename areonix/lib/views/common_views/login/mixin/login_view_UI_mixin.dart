import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/error_constants.dart';
import 'package:areonix/core/constants/string/route_constants.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:areonix/views/common_views/login/provider/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'login_view_mixin.dart';

mixin LoginViewUIMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T>, LoginViewMixin<T> {
  Widget loginButton(BuildContext context, WidgetRef ref) {
    return GradientButton(
      text: StringConstants.loginButton,
      onPressed: () => login(context, ref),
    );
  }

  TextButton loginRegister(BuildContext context) {
    return TextButton(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NormalText(
            text: StringConstants.loginDontHave,
            textStyle: context.general.textTheme.titleSmall,
            color: TColor.black,
          ),
          BoldText(
            text: StringConstants.loginRegister,
            textStyle: context.general.textTheme.titleSmall,
          ),
        ],
      ),
      onPressed: () {
        context.route.navigateName(RouteConstant.chooseView);
      },
    );
  }

  SizedBox loginLine() {
    return SizedBox(
      width: kIsWeb ? 50.w : 75.w,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: TColor.grey.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  TextButton loginForgot(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.route.navigateName(RouteConstant.changePasswordView);
      },
      child: NormalText(
        text: StringConstants.loginForgot,
        textStyle: context.general.textTheme.titleSmall?.copyWith(
            decoration: TextDecoration.underline, color: TColor.black),
      ),
    );
  }

  Column loginTextfieldArea(BuildContext context) {
    return Column(
      children: [
        RoundTextFormField(
          controller: emailController,
          labelText: StringConstants.loginEmail,
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return ErrorConstants.loginMailError;
            }
            return null;
          },
        ),
        context.sized.emptySizedHeightBoxLow3x,
        Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(loginProvider);

            return RoundTextFormField(
              controller: passwordController,
              labelText: StringConstants.signUpPassword,
              icon: Icons.lock,
              secureText: state.isVisible ? true : false,
              rightIcon: TextButton(
                onPressed: () {
                  ref.read(loginProvider.notifier).changeVisibility();
                },
                child: Icon(
                  state.isVisible ? Icons.visibility : Icons.visibility_off,
                  color: TColor.grey,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ErrorConstants.loginPasswordError;
                }
                return null;
              },
            );
          },
        ),
      ],
    );
  }

  Column loginTitle(BuildContext context) {
    return Column(
      children: [
        NormalText(
          text: StringConstants.loginWelcome,
          textStyle: context.general.textTheme.bodyLarge,
          color: TColor.black,
        ),
        BoldText(
          text: StringConstants.loginWelcomeBack,
          textStyle: context.general.textTheme.titleMedium,
        ),
      ],
    );
  }
}
