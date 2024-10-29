import 'dart:io';

import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/utility/firebase/index.dart';
import 'package:areonix/views/client/splash_client/provider/index.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

mixin ReportClientMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final Map<String, XFile?> _selectedImages = {};
  final Map<String, String?> tempImageUrls = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final mealTimes = ref.read(clientProvider).currentDayMealTimes ?? [];
    for (var mealTime in mealTimes) {
      _selectedImages[mealTime] = null;
      tempImageUrls[mealTime] = null;
    }
    print("Report Client Mixin Mealtimes : $mealTimes");
  }

  List<String> get mealTimes =>
      ref.read(clientProvider).currentDayMealTimes ?? [];

  Map<String, XFile?> get selectedImages => _selectedImages;

  Future<String?> uploadImageToStorage(XFile image, String path) async {
    try {
      final imageFile = File(image.path);

      if (await imageFile.exists()) {
        print('File exists and is ready for upload: ${image.path}');
      } else {
        print('File does not exist at path: ${image.path}');
        return null;
      }

      final storageRef = FirebaseStorage.instance.ref().child(path);
      final uploadTask = await storageRef.putFile(imageFile);

      if (uploadTask.state == TaskState.success) {
        final downloadURL = await storageRef.getDownloadURL();
        print('Upload successful. Download URL: $downloadURL');
        return downloadURL;
      } else {
        print('Upload failed: ${uploadTask.state}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> pickImage(String mealTime, ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        isLoading = true; // Loading başlat
        _selectedImages[mealTime] = image;
      });

      final clientId = ref.read(clientProvider).clientID ?? 'default_client';

      // Türkiye saatine göre tarih
      final currentDate = DateTime.now().toUtc().add(const Duration(hours: 3));
      final formattedDate =
          '${currentDate.day}-${currentDate.month}-${currentDate.year}';

      final storagePath =
          'clients/$clientId/reports/$formattedDate/$mealTime.jpg';

      final downloadUrl = await uploadImageToStorage(image, storagePath);

      if (downloadUrl != null) {
        setState(() {
          tempImageUrls[mealTime] = downloadUrl;
          isLoading = false; // Loading tamamlandı
        });
        await updateClientReports(clientId, mealTime, downloadUrl);
      } else {
        setState(() {
          isLoading = false; // Hata durumunda da loading'i kapat
        });
      }
    }
  }

  Future<void> updateClientReports(
    String clientId,
    String mealTime,
    String downloadUrl,
  ) async {
    final currentDay = getCurrentDay();

    // Firestore'daki verileri güncelle
    final clientDoc = FirebaseCollections.client.reference.doc(clientId);
    await clientDoc.update({
      'daily_report.$mealTime':
          downloadUrl, // Mevcut gün ve mealTime için resim URL'si
      'daily_report_submitted.$currentDay.$mealTime':
          true, // Mevcut gün için mealTime true
    });

    // Realtime Database'deki verileri güncelle
    final clientRef =
        FirebaseDatabase.instance.ref().child('client').child(clientId);

    await clientRef
        .child('daily_report/$mealTime')
        .set(downloadUrl); // Mevcut gün ve mealTime için resim URL'si
    await clientRef
        .child('daily_report_submitted/$currentDay/$mealTime')
        .set(true); // Mevcut gün için mealTime true
  }

  String getCurrentDay() {
    final currentDayIndex = DateTime.now().weekday;

    return StringConstants.daysOfWeek[currentDayIndex - 1];
  }
}
