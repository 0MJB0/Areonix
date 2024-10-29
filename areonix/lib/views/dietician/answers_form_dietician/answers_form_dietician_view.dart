import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mixin/answers_form_dietician_UI_mixin.dart';
import 'mixin/answers_form_dietician_mixin.dart';

class FormAnswersDieticianView extends ConsumerStatefulWidget {
  const FormAnswersDieticianView({super.key});

  @override
  ConsumerState<FormAnswersDieticianView> createState() =>
      _FormAnswersDieticianScreenState();
}

class _FormAnswersDieticianScreenState
    extends ConsumerState<FormAnswersDieticianView>
    with FormAnswersDieticianMixin, FormAnswersDieticianUIMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  formBuilder(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
