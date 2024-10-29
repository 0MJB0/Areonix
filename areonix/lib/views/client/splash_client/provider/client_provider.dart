import 'dart:convert';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/models/index.dart';
import 'package:areonix/core/utility/firebase/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'client_state.dart';

class ClientNotifier extends StateNotifier<ClientState> with FirebaseUtility {
  ClientNotifier() : super(const ClientState());

  Future<void> fetchAndLoad() async {
    state = state.copyWith(isLoading: true);

    // Client bilgilerini al ve clientID'yi güncelle
    await fetchClientInformation();

    // Client ID'yi kontrol edin ve dosyaları çekme ve silme fonksiyonunu çağırın
    if (state.clientID != null && state.clientID!.isNotEmpty) {
      await fetchFilesListAndDeleteOldFiles(state.clientID!);
    } else {
      print("Client ID is null or empty.");
    }

    state = state.copyWith(isLoading: false);
  }

  // Dosya adlarını Firebase Function'dan çekme
  Future<void> fetchFilesListAndDeleteOldFiles(String clientId) async {
    final url = Uri.parse(
      'https://us-central1-dietracker0.cloudfunctions.net/getFilesList?clientId=$clientId',
    );
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // JSON'u çöz ve dinamik bir liste olarak al
        final decodedJson = json.decode(response.body) as List<dynamic>;

        // Dosya adlarını string listesi olarak dönüştür
        List<String> fileNames =
            decodedJson.map((item) => item.toString()).toList();

        // Eski dosyaları sil
        await _deleteOldFiles(fileNames);

        print('Processed and deleted old files: $fileNames');
      } else {
        print(
          'Failed to fetch file names. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching file names: $e');
    }
  }

  Future<void> _deleteOldFiles(List<String> fileNames) async {
    // Yerel zaman kullanıyoruz, UTC'ye çevirme kaldırıldı
    final today = DateTime.now()
        .add(const Duration(hours: 3)); // 3 saat eklenmiş yerel zaman
    final threeDaysAgo = today.subtract(const Duration(days: 3)); // 3 gün önce

    print("today $today");
    print("three days ago $threeDaysAgo");

    for (final filePath in fileNames) {
      // Dosya yolundaki tarih segmentini çıkarma (hem tek hem çift haneli gün/ay için)
      final dateRegExp = RegExp(r'(\d{1,2})-(\d{1,2})-(\d{4})');
      final match = dateRegExp.firstMatch(filePath);

      if (match != null) {
        final day = int.parse(match.group(1)!); // Gün (DD)
        final month = int.parse(match.group(2)!); // Ay (MM)
        final year = int.parse(match.group(3)!); // Yıl (YYYY)

        // Dosya yolundaki tarihi yerel DateTime nesnesine dönüştürme
        final DateTime fileDate =
            DateTime(year, month, day); // Yerel tarih formatına uygun

        print('File date: $fileDate');

        // Eğer dosya tarihi 3 gün önceyse veya daha eskisi ise, dosyayı sil
        if (fileDate.isBefore(threeDaysAgo)) {
          final storageRef = FirebaseStorage.instance.ref();
          final fileRef = storageRef.child(filePath);

          try {
            print('Deleting file: $filePath');
            await fileRef.delete();
            print('File deleted: $filePath');
          } catch (e) {
            print('Error deleting file $filePath: $e');
          }
        } else {
          print('File not deleted (within the last 3 days): $filePath');
        }
      } else {
        print('No valid date found in file path: $filePath');
      }
    }
  }

  String getCurrentDay() {
    int currentDayIndex = DateTime.now().weekday;

    return StringConstants.daysOfWeek[currentDayIndex - 1];
  }

  List<String> getCurrentDayMealTimes(
    Map<String, Map<String, List<String>>>? diet,
  ) {
    // Mevcut günü al
    final currentDay = getCurrentDay();

    // Mevcut günün öğünlerini diet'ten al, yoksa boş bir liste döner
    return diet?[currentDay]?.keys.toList() ?? [];
  }

  Future<void> fetchClientInformation() async {
    try {
      // Kullanıcının oturumunun açık olup olmadığını kontrol ediyoruz
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        print("Kullanıcı oturumu açık değil.");
        return;
      }

      // Kullanıcı verisini Firebase'den çekiyoruz
      final items = await fetchList<Client, Client>(
        Client(),
        FirebaseCollections.client,
        queryBuilder: (query) => query.where('id', isEqualTo: userId),
      );

      if (items != null && items.isNotEmpty) {
        final client = items.first;

        // Gelen verileri yazdırıyoruz (debug amaçlı)
        print("Fetched client data: ${client.toJson()}");

        // State'i güncelliyoruz, her bir değeri null kontrolü yaparak alıyoruz
        final currentDayMealTimes = getCurrentDayMealTimes(client.diet);

        state = state.copyWith(
          clientID: client.id ?? '',
          clientName: client.name ?? '',
          clientSurname: client.surname ?? '',
          clientMail: client.mail ?? '',
          currentDayMealTimes: currentDayMealTimes,
          diet: client.diet ?? {},
          responses: client.responses ?? {},
          isFormSubmitted: client.isFormSubmitted ?? <String, bool>{},
          password: client.password ?? '',
          dailyReport: client.dailyReport ?? {},
          dailyReportSubmitted: client.dailyReportSubmitted ?? {},
          dieticianForms: client.dieticianForms ?? {},
          dailyDeletedTime: client.dailyDeletedTime ?? '',
        );
      } else {
        print("No client data found.");
      }
    } catch (e, stackTrace) {
      print("Error fetching client data: $e");
      print(stackTrace);
    }
  }

  void updateFormSubmissionState(String formID, bool isSubmitted) async {
    // Mevcut form gönderim durumunu kopyalıyoruz
    final updatedFormSubmission =
        Map<String, bool>.from(state.isFormSubmitted ?? {});

    // İlgili formun gönderim durumunu güncelliyoruz
    updatedFormSubmission[formID] = isSubmitted;

    // Yeni gönderim durumu ile state'i güncelliyoruz
    state = state.copyWith(isFormSubmitted: updatedFormSubmission);

    // Veritabanında da güncelleme işlemi yapıyoruz
    try {
      // Kullanıcı ID'sini alıyoruz
      final clientID = state.clientID;

      if (clientID != null && clientID.isNotEmpty) {
        // Firestore'daki form gönderim durumunu güncelleme
        await FirebaseFirestore.instance
            .collection('client')
            .doc(clientID)
            .update({
          'isFormSubmitted':
              updatedFormSubmission, // Güncellenmiş tüm form gönderim durumunu gönder
        });

        print('Form submission state updated successfully in Firestore.');
      } else {
        print('Client ID is null or empty. Cannot update Firestore.');
      }
    } catch (e) {
      print('Failed to update form submission state in Firestore: $e');
    }
  }

  void updateResponses(
    String clientId,
    String formName,
    Map<String, String> newResponses,
  ) {
    // Assuming the state has a `responses` map that needs to be updated
    final currentState = state;
    final updatedResponses = currentState.responses ?? {};

    // Update or add the responses for the specific form
    if (updatedResponses.containsKey(formName)) {
      // Merge with existing data for this form
      updatedResponses[formName]!.addAll(newResponses);
    } else {
      // Insert new data for this form
      updatedResponses[formName] = newResponses;
    }

    print("updatedResponses $updatedResponses");

    // Update the state
    state = currentState.copyWith(responses: updatedResponses);

    // Update the responses in Firestore
    _updateResponsesInFirestore(clientId, updatedResponses);
  }

  Future<void> _updateResponsesInFirestore(
    String clientId,
    Map<String, Map<String, String>> updatedResponses,
  ) async {
    try {
      // Reference to the client's document in Firestore
      final clientDocRef =
          FirebaseFirestore.instance.collection('client').doc(clientId);

      // Update the 'responses' field in the document
      await clientDocRef.update({
        'responses': updatedResponses,
      });

      print("Responses updated in Firestore successfully.");
    } catch (e) {
      print("Error updating Firestore: $e");
      // Handle the error, e.g., show a snackbar, log the error, etc.
    }
  }

  Future<void> checkAndResetDailyReport(
    String clientId,
    List<String> mealTimes,
    String? dailyDeletedTime,
  ) async {
    try {
      // Eğer dailyDeletedTime null ise fonksiyondan çık
      if (dailyDeletedTime == null || dailyDeletedTime.isEmpty) {
        print('dailyDeletedTime null ya da boş, işlem yapılmadı.');
        return;
      }

      // Şu anki Türkiye saatini al ve sadece tarih kısmını "DD-MM-YYYY" formatında al
      DateTime now = DateTime.now().toUtc().add(const Duration(hours: 3));
      String currentDateStr =
          "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";

      // Tarih kontrolü; güncel tarih, 'dailyDeletedTime' tarihinden büyükse sıfırla
      if (currentDateStr.compareTo(dailyDeletedTime) >= 0) {
        // Eğer tarih geçmişse 'daily_report' ve 'daily_report_submitted' alanlarını sıfırla
        await FirebaseCollections.client.reference.doc(clientId).update({
          'daily_report': null, // daily_report alanını sıfırla
          'daily_report_submitted':
              FieldValue.delete(), // daily_report_submitted alanını sıfırla
        });

        // MealTimes'den gelen öğünlerin 'daily_report_submitted' değerlerini false yap
        Map<String, Map<String, bool>> newDailyReportSubmitted = {};

        // Yeni bir 'daily_deleted_time' ayarla (yarın 00:00)
        DateTime nextUpdateTime =
            DateTime(now.year, now.month, now.day + 1, 0, 0, 0);
        String nextUpdateTimeStr =
            "${nextUpdateTime.day.toString().padLeft(2, '0')}-${nextUpdateTime.month.toString().padLeft(2, '0')}-${nextUpdateTime.year}";

        // Firestore'da yeni verileri güncelle
        await FirebaseCollections.client.reference.doc(clientId).set(
          {
            'daily_report_submitted':
                newDailyReportSubmitted, // Öğünlerin boolean değerleri
            'daily_deleted_time': nextUpdateTimeStr, // Sonraki silme zamanı
          },
          SetOptions(merge: true), // Mevcut veriyi koruyarak yeni veriyi ekle
        );

        // Yerel state'i güncelle
        state = state.copyWith(
          dailyReport: {}, // daily_report alanını boş bir map olarak güncelle
          dailyReportSubmitted:
              newDailyReportSubmitted, // Güncellenmiş daily_report_submitted
          dailyDeletedTime: nextUpdateTimeStr, // Güncellenmiş silme zamanı
        );

        print(
            'Günlük rapor ve daily_report_submitted sıfırlandı ve yeni tarih ayarlandı.');
      } else {
        print('Güncelleme zamanı henüz gelmedi, silme işlemi yapılmadı.');
      }
    } catch (e) {
      print('Günlük raporu sıfırlarken hata oluştu: $e');
    }
  }
}

final clientProvider = StateNotifierProvider<ClientNotifier, ClientState>(
  (ref) => ClientNotifier(),
);
