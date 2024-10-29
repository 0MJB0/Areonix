import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import 'mixin/edit_diet_dietician_UI_mixin.dart';
import 'mixin/edit_diet_dietician_mixin.dart';

class EditDietDieticianView extends ConsumerStatefulWidget {
  const EditDietDieticianView({super.key});

  @override
  ConsumerState<EditDietDieticianView> createState() =>
      _EditDietDieticianViewState();
}

class _EditDietDieticianViewState extends ConsumerState<EditDietDieticianView>
    with EditDietDieticianMixin, EditDietDieticianUIMixin {
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
      bottomNavigationBar: updateDietButton(),
    );
  }
}
