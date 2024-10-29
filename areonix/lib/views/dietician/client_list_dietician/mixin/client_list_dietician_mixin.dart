import 'package:areonix/core/constants/string/alert_dialog_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:areonix/views/dietician/splash_dietician/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/client_list_dietician_provider.dart';

mixin ClientListDieticianMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController dropdownFormSearchFieldController =
      TextEditingController();
  final TextEditingController dropdownDietSearchFieldController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    // Call refreshClients when the state initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(clientListDieticianProvider.notifier).refreshClients(ref);
    });
  }

  Future<List<String>> getFormSuggestions(String query) async {
    // DieticianState'deki mevcut duruma erişim
    final dieticianState = ref.read(dieticianProvider);

    // DieticianState'den gelen form isimlerini alın
    final formNames = <String>[];

    if (dieticianState.dieticianForms != null) {
      // DieticianForms bir Map<String, List<String>> olduğundan, key'leri direkt alabiliriz
      formNames.addAll(dieticianState.dieticianForms!.keys);
    }

    // Gelen form isimlerini filtreleyin
    final matches = <String>[];
    matches
      ..addAll(formNames)
      ..retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));

    return Future.value(matches);
  }

  void showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    String clientId,
    String name,
    String surname,
  ) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(
          title: '$name $surname',
          content: AlertDialogConstants.confirmClientListDeleteContent,
          onConfirm: () {
            ref
                .read(clientListDieticianProvider.notifier)
                .removeClient(clientId);
          },
        );
      },
    );
  }
}
