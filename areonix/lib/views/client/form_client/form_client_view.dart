import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/index.dart';
import 'mixin/form_client_UI_mixin.dart';
import 'mixin/form_client_mixin.dart';

class FormClientView extends ConsumerStatefulWidget {
  const FormClientView({super.key});

  @override
  _FormClientViewState createState() => _FormClientViewState();
}

class _FormClientViewState extends ConsumerState<FormClientView>
    with FormClientMixin, FormClientUIMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, ref),
      backgroundColor: TColor.white,
      body: Form(
        key: formKey,
        child: pageView(ref),
      ),
    );
  }
}
