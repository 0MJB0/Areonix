import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Notifier to manage the current form title
class FormClientTitleNotifier extends StateNotifier<String> {
  FormClientTitleNotifier() : super(StringConstants.formTitle);

  // Method to update the title
  void updateTitle(String newTitle) {
    state = newTitle;
  }

  // Method to reset the title to default
  void resetTitle() {
    state = StringConstants.formTitle;
  }
}

// Provider for the form title
final informationMemberTitleProvider =
    StateNotifierProvider<FormClientTitleNotifier, String>((ref) {
  return FormClientTitleNotifier();
});
