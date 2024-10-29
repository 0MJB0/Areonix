import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'mixin/personal_dietician_UI_mixin.dart';
import 'mixin/personal_dietician_mixin.dart';

class PersonalDieticianView extends ConsumerWidget
    with PersonalDieticianMixin, PersonalDieticianUIMixin {
  const PersonalDieticianView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: appbarPersonalMemberView(),
      body: Padding(
        padding: context.padding.medium,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              context.sized.emptySizedHeightBoxNormal,
              idCard(context, ref), // Pass ref to the mixin method
              context.sized.emptySizedHeightBoxNormal,
              nameCard(context, ref), // Pass ref to the mixin method
              context.sized.emptySizedHeightBoxNormal,
              surnameCard(context, ref), // Pass ref to the mixin method
              context.sized.emptySizedHeightBoxNormal,
              mailCard(context, ref), // Pass ref to the mixin method
              context.sized.emptySizedHeightBoxHigh,
            ],
          ),
        ),
      ),
    );
  }
}