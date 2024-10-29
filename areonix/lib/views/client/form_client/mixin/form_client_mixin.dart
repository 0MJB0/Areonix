import 'package:areonix/core/models/index.dart';
import 'package:areonix/core/widget/snackbar/custom_snackbar.dart';
import 'package:areonix/views/client/splash_client/provider/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin FormClientMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final PageController pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int currentPage = 0;

  List<TextEditingController> controllers = [];
  List<String> questions = [];

  void initializeControllers(List<String> questionsList) {
    questions = questionsList;
    controllers = questions.map((_) => TextEditingController()).toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Defer the logic to read from the provider until after the build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final questions = ref.read(clientProvider).questions ?? [];
      initializeControllers(questions);
    });
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    pageController.dispose(); // Dispose the page controller as well
    super.dispose();
  }

  void showErrorSnackBar(BuildContext context, Object e) {
    showCustomSnackBar(
      context: context,
      message: 'An error occurred: $e',
    );
  }

  Future<void> saveClientResponse(Client client) async {
    final collectionReference = FirebaseFirestore.instance.collection('client');

    try {
      await collectionReference.doc(client.id).set(client.toJson());
    } catch (e) {
      throw Exception('Failed to save client response: $e');
    }
  }
}
