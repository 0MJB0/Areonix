import 'package:areonix/core/constants/string/route_constants.dart';
import 'package:areonix/views/dietician/form_dietician/provider/form_dietician_provider.dart';
import 'package:areonix/views/dietician/splash_dietician/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

mixin CreateFormDieticianMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  final List<String> questions = [];
  final TextEditingController formNameController = TextEditingController();

  // Soruları eklerken sadece String türünde ekleyeceğiz
  void addQuestion() {
    setState(() {
      questions.add(''); // Boş bir soru ekliyoruz
    });
  }

  void removeQuestion(int index) {
    setState(() {
      questions.removeAt(index); // Soruyu listeden çıkarıyoruz
    });
  }

// Örneğin, sendForm metodunuzda
  Future<void> sendForm() async {
    final formName = formNameController.text;
    if (formName.isEmpty) {
      print('Form name is required.');
      return;
    }

    final dieticianState = ref.watch(dieticianProvider);

    if (dieticianState.isLoading) {
      print("Dietician data is loading...");
      return;
    }

    final dieticianId = dieticianState.id;

    if (dieticianId == null) {
      print("Dietician ID is null.");
      return;
    }

    // Formu göndermek için provider'ı kullanın
    await ref.read(formDieticianProvider.notifier).addForm(
          dieticianId,
          formName,
          questions,
          context,
        );
    await context.route.navigateName(RouteConstant.homeDietician);

    // Formu temizleyin
    setState(() {
      formNameController.clear();
      questions.clear();
    });
  }
}
