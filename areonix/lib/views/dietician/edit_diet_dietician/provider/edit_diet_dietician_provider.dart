import 'package:areonix/core/utility/firebase/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditDietNotifier extends StateNotifier<Map<String, List<String>>> {
  EditDietNotifier() : super({});

  // Öğün ve içerik bilgilerini güncelleme
  void updateMealDetails(Map<String, List<String>> mealDetails) {
    state = mealDetails;
  }

  Future<void> sendDiet(
    String clientId,
    Map<String, Map<String, bool>> dailyReportData,
    Map<String, Map<String, List<String>>> mealDetailsByDay,
  ) async {
    print("clientId: $clientId");
    print("mealDetailsByDay: $mealDetailsByDay"); // Yeni diyet verisi
    print("dailyReportData: $dailyReportData"); // Yeni günlük rapor verisi

    try {
      // Önce 'diet' ve 'daily_report_submitted' alanlarını temizle
      await FirebaseCollections.client.reference.doc(clientId).update({
        'diet': FieldValue.delete(),
        'daily_report_submitted': FieldValue.delete(),
      });

      // Şu anki Türkiye saatini al
      final now = DateTime.now().toUtc().add(const Duration(hours: 3));

      // Yarının sadece tarihini string formatına çevir (DD-MM-YYYY)
      final nextUpdateTime =
          "${(now.day + 1).toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";

      // Yeni diyet verisini mealDetailsByDay ile gönder
      await FirebaseCollections.client.reference.doc(clientId).set(
        {
          'diet': mealDetailsByDay,
          'daily_report_submitted': dailyReportData,
          'daily_deleted_time': nextUpdateTime,
        },
        SetOptions(merge: true),
      );

      print('Diyet Firestore\'a gönderildi: $mealDetailsByDay');
      print('daily_report_submitted Firestore\'a gönderildi: $dailyReportData');
      print('Bir sonraki silme zamanı (Tarih olarak): $nextUpdateTime');
    } catch (e) {
      print('Diyet gönderiminde hata: $e');
    }
  }

  Future<Map<String, Map<String, List<String>>>> getDiet(
    String clientId,
  ) async {
    try {
      // Firestore'daki diyet belgesini alıyoruz
      final snapshot =
          await FirebaseCollections.client.reference.doc(clientId).get();
      final data = snapshot.data()
          as Map<String, dynamic>?; // Veriyi Map olarak cast ediyoruz

      // Verinin boş olup olmadığını kontrol ediyoruz
      if (data != null && data['diet'] is Map<String, dynamic>) {
        // 'diet' alanını alıyoruz ve doğru yapıya dönüştürüyoruz
        final dietData = data['diet'] as Map<String, dynamic>;

        // Map<String, Map<String, List<String>>> yapısına dönüştürüyoruz
        return dietData.map(
          (day, meals) {
            final mealMap = meals as Map<dynamic,
                dynamic>; // meals'ı dinamikten Map'e çeviriyoruz
            return MapEntry(
              day,
              mealMap.map((mealName, contents) {
                // mealName: String, contents: List<String> olacak şekilde dönüştürüyoruz
                return MapEntry(
                  mealName as String,
                  List<String>.from(contents as List<dynamic>),
                );
              }),
            );
          },
        );
      }
    } catch (e) {
      print('Diyet getirme sırasında hata: $e');
    }

    // Eğer bir hata oluştuysa ya da diyet bulunamadıysa boş bir yapı döndür
    return {};
  }
}

final editDietNotifierProvider =
    StateNotifierProvider<EditDietNotifier, Map<String, List<String>>>(
  (ref) => EditDietNotifier(),
);
