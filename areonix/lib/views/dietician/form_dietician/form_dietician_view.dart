import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mixin/form_dietician_UI_mixin.dart';
import 'mixin/form_dietician_mixin.dart';

class FormDieticianView extends ConsumerStatefulWidget {
  const FormDieticianView({super.key});

  @override
  ConsumerState<FormDieticianView> createState() =>
      _FormDietDieticianViewState();
}

class _FormDietDieticianViewState extends ConsumerState<FormDieticianView>
    with FormDieticianMixin, FormDieticianUIMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                formCard(context, ref),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
