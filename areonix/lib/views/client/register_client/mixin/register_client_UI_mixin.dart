import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/error_constants.dart';
import 'package:areonix/core/constants/string/route_constants.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../provider/index.dart';
import 'register_client_mixin.dart';

mixin RegisterClientUIMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T>, RegisterClientMixin<T> {
  TextButton alreadyHaveAccountButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.route.navigateName(RouteConstant.loginView);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NormalText(
            text: StringConstants.signUpAlreadyHaveAccount,
            textStyle: context.general.textTheme.titleSmall,
          ),
          BoldText(
            text: StringConstants.signUpLogin,
            textStyle: context.general.textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  SizedBox straightLine() {
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

  Column textfieldArea(BuildContext context) {
    return Column(
      children: [
        RoundTextFormField(
          controller: nameController,
          labelText: StringConstants.signUpFirstName,
          icon: Icons.person,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return ErrorConstants.registerMemberNameError;
            }
            return null;
          },
        ),
        context.sized.emptySizedHeightBoxLow3x,
        RoundTextFormField(
          controller: surnameController,
          labelText: StringConstants.signUpLastName,
          icon: Icons.person_outline,
          iconColor: TColor.airforce,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return ErrorConstants.registerMemberSurnameError;
            }
            return null;
          },
        ),
        context.sized.emptySizedHeightBoxLow3x,
        RoundTextFormField(
          controller: emailController,
          labelText: StringConstants.signUpEmail,
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return ErrorConstants.registerMemberMailError;
            }
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return ErrorConstants.registerMemberProperMailError;
            }
            return null;
          },
        ),
        context.sized.emptySizedHeightBoxLow3x,
        Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(registerMemberProvider);

            return RoundTextFormField(
              controller: passwordController,
              labelText: StringConstants.signUpPassword,
              icon: Icons.lock,
              secureText: state.isVisible ? true : false,
              rightIcon: TextButton(
                onPressed: () {
                  ref.read(registerMemberProvider.notifier).changeVisibility();
                },
                child: Icon(
                  state.isVisible ? Icons.visibility : Icons.visibility_off,
                  color: TColor.grey,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ErrorConstants.registerMemberPasswordError;
                }
                if (value.length < 6) {
                  return ErrorConstants.registerMemberProperPasswordError;
                }
                return null;
              },
            );
          },
        ),
        context.sized.emptySizedHeightBoxLow3x,
        SizedBox(
          width: kIsWeb ? 50.w : 85.w,
          child: Row(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final state = ref.watch(registerMemberProvider);

                  return Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          ref
                              .read(registerMemberProvider.notifier)
                              .toggleCheck();
                        },
                        icon: Icon(
                          state.isCheck
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank_outlined,
                          color: TColor.grey,
                          size: 20,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          ref
                              .read(registerMemberProvider.notifier)
                              .toggleCheck();
                        },
                        child: NormalText(
                          text: StringConstants.signUpPolicy,
                          textStyle: context.general.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column welcomeTitle(BuildContext context) {
    return Column(
      children: [
        NormalText(
          text: StringConstants.registerClientWelcome,
          textStyle: context.general.textTheme.bodyMedium,
        ),
        BoldText(
          text: StringConstants.signUpCreateAccount,
          textStyle: context.general.textTheme.titleSmall,
        ),
      ],
    );
  }
}
