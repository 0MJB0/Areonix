import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Notifier to manage the current form title
class AnswersFormDieticanNotifier extends StateNotifier<String> {
  AnswersFormDieticanNotifier()
      : super(StringConstants.answersFormDieticianTitle);

  // Method to update the title
  void updateTitle(String newTitle) {
    state = newTitle;
  }

  // Method to reset the title to default
  void resetTitle() {
    state = StringConstants.answersFormDieticianTitle;
  }
}

// Provider for the form title
final answersFormDieticianProvider =
    StateNotifierProvider<AnswersFormDieticanNotifier, String>((ref) {
  return AnswersFormDieticanNotifier();
});
