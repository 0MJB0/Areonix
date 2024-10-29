import 'package:flutter/material.dart';

@immutable
class ErrorConstants {
  const ErrorConstants._();

  // Add Client
  static const String addClientIsClientAlreadyInDieticianList =
      'Bu hasta zaten diyetisyenin listesinde bulunuyor!';
  static const String addClientIsClientAlreadyAppointed =
      'Bu hasta başka bir diyetisyen tarafından eklenmiş!';
  static const String addClientIsClientADietician =
      'Bir diyetisyen hasta olarak eklenemez!';

  // Search Dietician
  static const String searchDieticianFormAlert =
      'Form seçimi yapmayı unuttunuz!';

  // Form Assign
  static const String formAssignErrorMessage =
      'Form gönderirken bir sorun oluştu!';

  // Information
  static const informationEmptyAlert = 'Bu alan boş bırakılamaz!';

  // Register Member
  static const registerMemberNameError = 'Lütfen isminizi giriniz!';
  static const registerMemberSurnameError = 'Lütfen soy isminizi giriniz!';
  static const registerMemberMailError = 'Lütfen mailinizi giriniz!';
  static const registerMemberProperMailError =
      'Lütfen düzgün formatta mailinizi giriniz!';
  static const registerMemberPasswordError = 'Lütfen şifrenizi giriniz!';
  static const registerMemberProperPasswordError =
      'Şifreniz en az 6 karakter içermelidir!';

  // Login
  static const loginMailError = 'Lütfen mailinizi giriniz!';
  static const loginPasswordError = 'Lütfen şifrenizi giriniz!';

  // Started
  static const startedUpdateRequired = 'Güncelleme gerekli!';

  // Answers Form Dietician
  static const answersFormNoForm = 'Hiç form bulunamadı.';
  static const answersFormNoAnswersForm = 'Formlar henüz cevaplanmamış.';
  static const answersFormSomethingWentWrong = 'Bir hata oluştu.';

  // Daily Report Check Dietician
  static const dailyReportCheckNoReport =
      'Danışanınız günlük raporlarını yüklemedi.';

  static const dailyReportMealUnknown = 'Bilinmiyor';

  //  Daily Report Details Dietician
  static const dailyReportDetailsNoMeals = 'Mevcut öğün yok!';
  static const dailyReportDetailsIDK = 'Bilinmiyor';
  static const dailyReportDetailsNoImage = 'Resim mevcut değil!';
  static const dailyReportDetailsNoDate = 'Tarih yok!';

  // Register Dietician
  static const registerDieticianNameError = 'Lütfen isminizi giriniz!';
  static const registerDieticianSurnameError = 'Lütfen soy isminizi giriniz!';
  static const registerDieticianMailError = 'Lütfen mailinizi giriniz!';
  static const registerDieticianProperMailError =
      'Lütfen düzgün formatta mailinizi giriniz!';
  static const registerDieticianPasswordError = 'Lütfen şifrenizi giriniz!';
  static const registerDieticianProperPasswordError =
      'Şifreniz en az 6 karakter içermelidir!';
}
