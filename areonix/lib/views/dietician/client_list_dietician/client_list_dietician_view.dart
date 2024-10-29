import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mixin/client_list_dietician_mixin.dart';
import 'mixin/client_list_dietician_view_UI_mixin.dart';

class ClientListDieticianView extends ConsumerStatefulWidget {
  @override
  ConsumerState<ClientListDieticianView> createState() =>
      _ClientListDieticianViewState();
}

class _ClientListDieticianViewState
    extends ConsumerState<ClientListDieticianView>
    with ClientListDieticianMixin, ClientListDieticianViewUIMixin {
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
                clientCard(context, ref),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
