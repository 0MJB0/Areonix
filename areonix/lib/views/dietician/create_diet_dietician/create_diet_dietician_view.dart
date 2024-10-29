import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import 'mixin/create_diet_dietician_UI_mixin.dart';
import 'mixin/create_diet_dietician_mixin.dart';

class CreateDietDieticianView extends ConsumerStatefulWidget {
  const CreateDietDieticianView({super.key});

  @override
  ConsumerState<CreateDietDieticianView> createState() =>
      _CreateDietDieticianViewState();
}

class _CreateDietDieticianViewState
    extends ConsumerState<CreateDietDieticianView>
    with CreateDietDieticianMixin, CreateDietDieticianUIMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          addMealButtonwithChooseDay(),
          context.sized.emptySizedHeightBoxLow3x,
          mealList(context),
        ],
      ),
      bottomNavigationBar: sendDietButton(),
    );
  }
}
