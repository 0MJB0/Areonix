import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import 'mixin/edit_form_dietician_UI_mixin.dart';
import 'mixin/edit_form_dietician_mixin.dart';

class EditFormDieticianView extends ConsumerStatefulWidget {
  const EditFormDieticianView({super.key});

  @override
  ConsumerState<EditFormDieticianView> createState() => _EditFormViewState();
}

class _EditFormViewState extends ConsumerState<EditFormDieticianView>
    with EditFormDieticianMixin, EditFormDieticianUIMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Padding(
        padding: context.padding.medium,
        child: Column(
          children: [
            buildFormNameField(), // Form adı alanı
            context.sized.emptySizedHeightBoxLow,
            buildAddQuestionButton(),
            context.sized.emptySizedHeightBoxLow,
            buildFormList(context), // Soru listesi
          ],
        ),
      ),
      bottomNavigationBar: buildSendFormButton(), // Formu gönderme butonu
    );
  }
}
