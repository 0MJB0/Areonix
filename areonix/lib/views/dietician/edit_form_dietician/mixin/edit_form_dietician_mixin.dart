import 'package:areonix/core/constants/string/route_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:areonix/views/dietician/splash_dietician/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import '../../form_dietician/provider/form_card_state.dart';
import '../../form_dietician/provider/form_dietician_provider.dart';
import '../edit_form_dietician_view.dart';

mixin EditFormDieticianMixin<T extends EditFormDieticianView>
    on ConsumerState<T> {
  final List<String> questions = [];
  final List<TextEditingController> questionControllers = [];
  TextEditingController formNameController = TextEditingController();
  DieticianFormState form =
      const DieticianFormState(); // Initialize with default value

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Extract the passed object from the route's arguments
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is DieticianFormState) {
      form = args;
    }

    // Populate formNameController and questions after form is initialized
    formNameController.text = form.formName ?? '';
    questions.addAll(form.questions ?? []);

    // Create controllers for each question
    for (var question in questions) {
      final controller = TextEditingController(text: question);
      questionControllers.add(controller);
    }
  }

  @override
  void dispose() {
    // Clean up controllers
    formNameController.dispose();
    for (var controller in questionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Add new question
  void addQuestion() {
    setState(() {
      questions.add(''); // Add empty question
      questionControllers.add(TextEditingController()); // Add a new controller
    });
  }

  // Remove a question
  void removeQuestion(int index) {
    setState(() {
      questions.removeAt(index); // Remove question
      questionControllers.removeAt(index); // Remove corresponding controller
    });
  }

  // Send the form (update form)
  Future<void> sendForm() async {
    final formName = formNameController.text;
    if (formName.isEmpty) {
      print('Form name is required.');
      return;
    }

    // Get the dieticianId from the state managed by dieticianProvider
    final dieticianId = ref.read(dieticianProvider).id;
    if (dieticianId == null) {
      print("Dietician ID is null.");
      return;
    }

    // Call the update form function
    await ref.read(formDieticianProvider.notifier).updateForm(
          dieticianId,
          formName, // Form name is used as the form ID
          questions, // Send the updated list of questions
        );

    // Show success message
    showCustomSnackBar(
      context: context,
      message: 'Form başarıyla güncellendi!',
    );
    await context.route.navigateName(RouteConstant.homeDietician);
  }
}
