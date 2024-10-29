import 'package:areonix/core/constants/string/alert_dialog_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:areonix/views/dietician/splash_dietician/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/form_dietician_provider.dart';

mixin FormDieticianMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final dieticianId = ref.read(dieticianProvider).id;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(formDieticianProvider.notifier).refreshForms(dieticianId!);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(formDieticianProvider.notifier).filterForms('');
    });

    // SearchController için dinleyici ekle
    searchController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(formDieticianProvider.notifier)
            .filterForms(searchController.text);
      });
    });
  }

  void deleteForm(String formId, String dieticianId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(formDieticianProvider.notifier).deleteForm(formId, dieticianId);
      ref
          .read(formDieticianProvider.notifier)
          .filterForms(searchController.text);
    });
  }

  void showDeleteDialog(
    BuildContext context,
    String formId,
    String dieticianId,
  ) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(
          title: formId,
          content: AlertDialogConstants.confirmDeleteContent,
          onConfirm: () {
            deleteForm(formId, dieticianId);
          },
        );
      },
    );
  }
}
