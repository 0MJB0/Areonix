import 'package:areonix/core/constants/string/alert_dialog_constants.dart';
import 'package:areonix/core/utility/firebase/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin FormAnswersDieticianMixin<T extends StatefulWidget> on State<T> {
  late String clientId;
  late Future<Map<String, Map<String, String>>?> formsFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // clientId'yi al
    clientId = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    // Üyenin form cevaplarını Firestore'dan al
    formsFuture = getResponses(clientId);
  }

  // Firestore'dan form cevaplarını getiren fonksiyon
  Future<Map<String, Map<String, String>>> getResponses(String clientId) async {
    try {
      final snapshot =
          await FirebaseCollections.client.reference.doc(clientId).get();
      final data = snapshot.data(); // Firestore'dan gelen veriyi alıyoruz
      if (data != null && data is Map<String, dynamic>) {
        final responsesData = data['responses'];
        if (responsesData is Map<String, dynamic>) {
          return responsesData.map((formName, formAnswers) {
            if (formAnswers is Map<String, dynamic>) {
              final answersMap = formAnswers.map(
                  (question, answer) => MapEntry(question, answer.toString()));
              return MapEntry(formName, answersMap);
            } else {
              return MapEntry(formName, <String, String>{});
            }
          });
        } else {
          print('responses alanı beklenen formatta değil.');
        }
      } else {
        print('Veri bulunamadı veya beklenen formatta değil.');
      }
    } catch (e) {
      print('Form cevaplarını getirme sırasında hata: $e');
    }
    return {};
  }

  void showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    String clientId,
    String FormName,
  ) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(
          title: FormName,
          content: AlertDialogConstants.confirmClientFormAnswersDeleteContent,
          onConfirm: () {},
        );
      },
    );
  }
}
