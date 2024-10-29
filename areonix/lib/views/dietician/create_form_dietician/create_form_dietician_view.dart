import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'mixin/create_form_dietician_UI_mixin.dart';
import 'mixin/create_form_dietician_mixin.dart';

class CreateFormDieticianView extends ConsumerStatefulWidget {
  const CreateFormDieticianView({super.key});

  @override
  ConsumerState<CreateFormDieticianView> createState() =>
      _CreateFormDieticianViewState();
}

class _CreateFormDieticianViewState
    extends ConsumerState<CreateFormDieticianView>
    with CreateFormDieticianMixin, CreateFormDieticianUIMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Padding(
        padding: context.padding.medium,
        child: Column(
          children: [
            buildFormNameField(),
            context.sized.emptySizedHeightBoxLow,
            buildAddQuestionButton(),
            context.sized.emptySizedHeightBoxLow,
            buildFormList(context),
          ],
        ),
      ),
      bottomNavigationBar: buildSendFormButton(),
    );
  }
}
