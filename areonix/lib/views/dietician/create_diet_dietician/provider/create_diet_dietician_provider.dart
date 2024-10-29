import 'package:areonix/core/utility/firebase/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider tanımlama
final dietBackendNotifierProvider =
    StateNotifierProvider<DietBackendNotifier, Map<String, List<String>>>(
  (ref) => DietBackendNotifier(),
);

class DietBackendNotifier extends StateNotifier<Map<String, List<String>>> {
  DietBackendNotifier() : super({});

  Future<void> sendDiet(
    String clientId,
    Map<String, Map<String, bool>> dailyReportData,
    Map<String, Map<String, List<String>>> mealDetailsByDay,
  ) async {
    try {
      await FirebaseCollections.client.reference.doc(clientId).update({
        'diet': FieldValue.delete(),
        'daily_report_submitted': FieldValue.delete(),
      });

      final now = DateTime.now().toUtc().add(const Duration(hours: 3));
      final nextUpdateTime =
          "${(now.day + 1).toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";

      await FirebaseCollections.client.reference.doc(clientId).set(
        {
          'diet': mealDetailsByDay,
          'daily_report_submitted': dailyReportData,
          'daily_deleted_time': nextUpdateTime,
        },
        SetOptions(merge: true),
      );

      print('Diyet Firestore gönderildi');
    } catch (e) {
      print('Diyet gönderiminde hata: $e');
    }
  }
}
