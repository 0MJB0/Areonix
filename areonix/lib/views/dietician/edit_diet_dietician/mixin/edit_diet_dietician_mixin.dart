import 'package:areonix/core/constants/string/route_constants.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import '../provider/edit_diet_dietician_provider.dart';

// Mix-in yapısı ile UI yönetimi
mixin EditDietDieticianMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  Map<String, List<String>> mealsByDay = {}; // Her gün için öğün isimleri
  Map<String, List<TextEditingController>> mealControllersByDay =
      {}; // Gün bazlı öğün adlarını yönetmek için
  Map<String, Map<String, List<TextEditingController>>>
      contentControllersByDay =
      {}; // Her gün ve öğün için içerikleri yönetmek için
  Map<String, Map<String, List<String>>> mealDetailsByDay =
      {}; // Gün bazlı öğün detayları

  // Eklenen yapılar
  Map<String, Map<String, List<TextEditingController>>> numberControllersByDay =
      {}; // Miktar için controller'lar
  Map<String, Map<String, List<TextEditingController>>>
      mealContentControllersByDay = {}; // Besin için controller'lar
  Map<String, Map<String, List<String>>> dropdownValueUnitControllersByDay =
      {}; // Birim için değerler

  late String clientId;
  late String selectedDay = 'Gün Seçiniz';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    clientId = ModalRoute.of(context)?.settings.arguments as String? ?? '';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadExistingDiet(ref); // Mevcut diyeti Firestore'dan çekip dolduruyoruz
    });
  }

  // Mevcut diyeti Firestore'dan yükleyip formu doldurma
  Future<void> _loadExistingDiet(WidgetRef ref) async {
    try {
      // Diyet verilerini Firestore'dan çekiyoruz
      final diet =
          await ref.read(editDietNotifierProvider.notifier).getDiet(clientId);

      setState(() {
        mealDetailsByDay = diet;
        mealsByDay = {};
        mealControllersByDay = {};
        contentControllersByDay = {};
        numberControllersByDay = {};
        mealContentControllersByDay = {};
        dropdownValueUnitControllersByDay = {};

        mealDetailsByDay.forEach((day, meals) {
          mealsByDay[day] = meals.keys.toList(); // Gün için öğün isimleri
          mealControllersByDay[day] = meals.keys.map((meal) {
            return TextEditingController(
              text: meal,
            ); // Öğün ismi için controller
          }).toList();

          contentControllersByDay[day] = {};
          numberControllersByDay[day] = {};
          mealContentControllersByDay[day] = {};
          dropdownValueUnitControllersByDay[day] = {};

          meals.forEach((meal, contents) {
            // İçerikleri ayırıp controller'lara bölüyoruz
            contentControllersByDay[day]![meal] = [];
            numberControllersByDay[day]![meal] = [];
            mealContentControllersByDay[day]![meal] = [];
            dropdownValueUnitControllersByDay[day]![meal] = [];

            for (final content in contents) {
              final splitContent = content.split('/');
              final amount = splitContent[1]; // Miktar
              final unit = splitContent[2]; // Birim
              final food = splitContent[3]; // Yemek

              numberControllersByDay[day]![meal]!
                  .add(TextEditingController(text: amount));
              dropdownValueUnitControllersByDay[day]![meal]!.add(unit);
              mealContentControllersByDay[day]![meal]!
                  .add(TextEditingController(text: food));
            }
          });
        });
      });
    } catch (e) {
      print('Diyet yüklenirken hata oluştu: $e');
    }
  }

  // Yeni öğün ekleme
  void addMeal() {
    setState(() {
      mealsByDay[selectedDay] ??= []; // Seçilen gün için öğün listesi başlat
      mealControllersByDay[selectedDay] ??=
          []; // Gün için controller listesi başlat
      contentControllersByDay[selectedDay] ??=
          {}; // Gün için içerik controller listesi başlat
      numberControllersByDay[selectedDay] ??=
          {}; // Gün için miktar controller'larını başlat
      mealContentControllersByDay[selectedDay] ??=
          {}; // Gün için besin controller'larını başlat
      dropdownValueUnitControllersByDay[selectedDay] ??=
          {}; // Gün için birim controller'larını başlat

      mealsByDay[selectedDay]!.add(''); // Yeni öğün ekle
      mealControllersByDay[selectedDay]!
          .add(TextEditingController()); // Yeni öğün controller ekle
      mealDetailsByDay[selectedDay] ??= {}; // Seçilen gün için öğün oluştur
      mealDetailsByDay[selectedDay]![''] = []; // Boş öğün adı ile başlat
      contentControllersByDay[selectedDay]![''] =
          []; // Yeni öğün için içerik controllers listesi oluştur
      numberControllersByDay[selectedDay]![''] =
          []; // Yeni öğün için miktar controllers listesi oluştur
      mealContentControllersByDay[selectedDay]![''] =
          []; // Yeni öğün için besin controllers listesi oluştur
      dropdownValueUnitControllersByDay[selectedDay]![''] =
          []; // Yeni öğün için birim controllers listesi oluştur
    });
  }

  // Öğünü kaldırma
  void removeMeal(int index) {
    setState(() {
      final mealName = mealsByDay[selectedDay]![index];
      mealDetailsByDay[selectedDay]!
          .remove(mealName); // Seçilen günün öğünlerini kaldır
      contentControllersByDay[selectedDay]!
          .remove(mealName); // İçerik controller'larını kaldır
      mealControllersByDay[selectedDay]!
          .removeAt(index); // Öğün controller'ını kaldır
      numberControllersByDay[selectedDay]!
          .remove(mealName); // Miktar controller'larını kaldır
      mealContentControllersByDay[selectedDay]!
          .remove(mealName); // Besin controller'larını kaldır
      mealsByDay[selectedDay]!.removeAt(index); // Öğünü kaldır
    });
  }

  // Öğünün içeriğine bir yemek ekleme
  void addMealContent(int mealIndex) {
    setState(() {
      final mealName = mealsByDay[selectedDay]![mealIndex];
      mealDetailsByDay[selectedDay]![mealName] ??= [];
      mealDetailsByDay[selectedDay]![mealName]!.add(''); // Boş içerik ekle
      contentControllersByDay[selectedDay]![mealName]!
          .add(TextEditingController());
      numberControllersByDay[selectedDay]![mealName]!
          .add(TextEditingController()); // Miktar için yeni controller
      mealContentControllersByDay[selectedDay]![mealName]!
          .add(TextEditingController()); // Besin için yeni controller
      dropdownValueUnitControllersByDay[selectedDay]![mealName]!.add('Seçiniz');
    });
  }

  void removeMealContent(int mealIndex, int contentIndex) {
    setState(() {
      final mealName = mealsByDay[selectedDay]![mealIndex];

      // mealDetailsByDay'deki listeyi kontrol ediyoruz
      if (mealDetailsByDay[selectedDay] != null &&
          mealDetailsByDay[selectedDay]![mealName] != null &&
          mealDetailsByDay[selectedDay]![mealName]!.length > contentIndex) {
        // Eğer içerik mevcutsa onu sil
        mealDetailsByDay[selectedDay]![mealName]!.removeAt(contentIndex);
      }

      // contentControllersByDay'deki listeyi kontrol ediyoruz
      if (contentControllersByDay[selectedDay] != null &&
          contentControllersByDay[selectedDay]![mealName] != null &&
          contentControllersByDay[selectedDay]![mealName]!.length >
              contentIndex) {
        // İçerik controller'ı sil
        contentControllersByDay[selectedDay]![mealName]!.removeAt(contentIndex);
      }

      // numberControllersByDay'deki listeyi kontrol ediyoruz
      if (numberControllersByDay[selectedDay] != null &&
          numberControllersByDay[selectedDay]![mealName] != null &&
          numberControllersByDay[selectedDay]![mealName]!.length >
              contentIndex) {
        // Miktar controller'ı sil
        numberControllersByDay[selectedDay]![mealName]!.removeAt(contentIndex);
      }

      // mealContentControllersByDay'deki listeyi kontrol ediyoruz
      if (mealContentControllersByDay[selectedDay] != null &&
          mealContentControllersByDay[selectedDay]![mealName] != null &&
          mealContentControllersByDay[selectedDay]![mealName]!.length >
              contentIndex) {
        // Yemek controller'ı sil
        mealContentControllersByDay[selectedDay]![mealName]!
            .removeAt(contentIndex);
      }

      // dropdownValueUnitControllersByDay'deki listeyi kontrol ediyoruz
      if (dropdownValueUnitControllersByDay[selectedDay] != null &&
          dropdownValueUnitControllersByDay[selectedDay]![mealName] != null &&
          dropdownValueUnitControllersByDay[selectedDay]![mealName]!.length >
              contentIndex) {
        // Birim controller'ı sil
        dropdownValueUnitControllersByDay[selectedDay]![mealName]!
            .removeAt(contentIndex);
      }
    });
  }

  Future<void> sendDiet(WidgetRef ref) async {
    try {
      var hasEmptyFields = false;
      final incompleteDays = <String>[]; // Eksik günler için liste
      var emptyMealName = '';

      // Her günün en az bir öğün içerip içermediğini ve içeriklerin boş olup olmadığını kontrol et
      for (final day in StringConstants.daysOfWeek) {
        // Eğer gün için öğün yoksa, eksik olarak işaretle
        if (!mealDetailsByDay.containsKey(day) ||
            mealDetailsByDay[day]!.isEmpty) {
          incompleteDays.add(day);
          continue;
        }

        // O günün her öğününü kontrol et
        for (final meal in mealDetailsByDay[day]!.keys) {
          // Eğer öğün boşsa veya içerikleri yoksa eksik olarak işaretle
          if (mealDetailsByDay[day]![meal] == null ||
              mealDetailsByDay[day]![meal]!.isEmpty) {
            hasEmptyFields = true;
            emptyMealName = '$day - $meal öğününün içeriği eksik';
            incompleteDays.add(day);
            break;
          }

          // Eğer içerikler varsa onları kontrol et (miktar, birim ve besin boş mu)
          final numberControllers = numberControllersByDay[day]![meal]!;
          final mealContentControllers =
              mealContentControllersByDay[day]![meal]!;
          final dropdownUnits = dropdownValueUnitControllersByDay[day]![meal]!;

          for (int i = 0; i < mealDetailsByDay[day]![meal]!.length; i++) {
            final mealContent = mealDetailsByDay[day]![meal]![i];
            final numberContent = numberControllers[i].text;
            final mealItem = mealContentControllers[i].text;
            final unit = dropdownUnits[i]; // Seçilen birim (dropdown value)

            // Eğer içerik, miktar, birim ya da besin boşsa eksik olarak işaretle
            if (mealContent.isEmpty ||
                numberContent.isEmpty ||
                mealItem.isEmpty ||
                unit.isEmpty) {
              hasEmptyFields = true;
              emptyMealName =
                  '$day - $meal öğününün miktarı, birimi veya içeriği eksik';
              incompleteDays.add(day);
              break;
            }
          }
        }
      }

      // Eğer eksik günler veya öğünler varsa uyarı mesajı göster
      if (hasEmptyFields || incompleteDays.isNotEmpty) {
        final missingDaysMessage = incompleteDays.join(', ');
        final message = hasEmptyFields
            ? 'Lütfen şu günlerde eksik olan öğün ve içerikleri doldurun: $emptyMealName'
            : 'Lütfen şu günlerde en az bir öğün ve içeriği ekleyin: $missingDaysMessage';

        showCustomSnackBar(
          context: context,
          message: message,
          duration: const Duration(seconds: 5),
        );
        return;
      }

      // Günlük öğün verisini hazırlıyoruz
      final dailyReportData = <String, Map<String, bool>>{};

      // Her gün ve öğün için boolean değer ekliyoruz
      for (final day in mealDetailsByDay.keys) {
        final dailyMeals = <String, bool>{};

        for (final meal in mealDetailsByDay[day]!.keys) {
          // Her günün her öğünü için 'false' değeri atanıyor
          dailyMeals[meal] = false;
        }

        dailyReportData[day] = dailyMeals; // Her günün öğünlerini atıyoruz
      }

      print('Diyet Gönderiliyor: $mealDetailsByDay');
      print('Daily Report Submitted: $dailyReportData');

      // Diyeti backend'e gönder
      await ref.read(editDietNotifierProvider.notifier).sendDiet(
            clientId,
            dailyReportData,
            mealDetailsByDay,
          );
      showCustomSnackBar(
        context: context,
        message: 'Diyet başarılı bir şekilde güncellendi',
      );
      await context.route.navigateName(RouteConstant.homeDietician);
    } catch (e) {
      print('Diyet gönderiminde hata: $e');
      showCustomSnackBar(
        context: context,
        message: 'Diyet gönderilirken hata oluştu.',
      );
    }
  }

  String replaceDotWithColon(String input) {
    return input.replaceAll('.', ':');
  }

  String replaceDotWithComma(String input) {
    return input.replaceAll('.', ',');
  }
}
