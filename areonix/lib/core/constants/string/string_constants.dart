import 'package:flutter/material.dart';

@immutable
class StringConstants {
  const StringConstants._();

  static const List<String> daysOfWeek = [
    'Pazartesi', // 1
    'Salı', // 2
    'Çarşamba', // 3
    'Perşembe', // 4
    'Cuma', // 5
    'Cumartesi', // 6
    'Pazar' // 7
  ];

  // App Version
  static const String appVersion = '1.0.0';

  // General
  static const String appName = 'Areonix';

  // Register Dietician
  static const String registerDieticianWelcome =
      'Diyetisyen Kayıt Ekranına Hoşgeldiniz ';
  static const String registerDieticianTitle = 'Diyetisyen Kayıt Ekranı ';

  // Register Member
  static const String registerClientWelcome = 'Üye Kayıt Ekranına Hoşgeldiniz ';
  static const String registerClientTitle = 'Üye Kayıt Ekranı';
  // Register View
  static const String registerSuccessRouteMessage =
      'Başarılı bir şekilde kayıt oldunuz!\nGiriş ekranına yönlendiriliyorsunuz...';

  // Choose View
  static const String chooseMember = 'Üye';
  static const String chooseDietician = 'Diyetisyen';
  static const String chooseTitle = 'Nasıl Kayıt Olmak İstersiniz ?';

  // Home
  static const homeBrowse = 'Keşfet';
  static const homeMessage =
      'Sizi tekrar gördüğüme sevindim. Giriş yaparak kaldığınız yerden devam edebilirsiniz';

  static const homeTitle = 'Size Önerilenler';
  static const homeSeeAll = 'Hepsini gör';
  static const homeSearchHint = 'Ara';
  static const addItemTitle = 'Yeni öğe ekle';

  // Component
  static const String dropdownHint = 'Öğeleri Seç';
  static const String dropdownTitle = 'Başlık';
  static const String buttonSave = 'Kaydet';

  // Sign Up

  static const signUpWelcome = 'Merhaba,';
  static const signUpCreateAccount = 'Hesap Oluştur';
  static const signUpFirstName = 'Ad';
  static const signUpLastName = 'Soyad';
  static const signUpEmail = 'E-posta';
  static const signUpPassword = 'Şifre';
  static const signUpPolicy =
      'Devam ederek Gizlilik Politikamızı ve\nKullanım Şartlarını kabul etmiş olursunuz';
  static const signUpRegister = 'Kaydol';
  static const signUpAlreadyHaveAccount = 'Zaten bir hesabınız var mı? ';
  static const signUpLogin = 'Giriş Yap';

  //Login

  static const loginWelcome = 'Merhaba,';
  static const loginWelcomeBack = 'Tekrar Hoşgeldiniz 👋';
  static const loginEmail = 'Email';
  static const loginForgot = 'Şifrenizi mi Unuttunuz ? ';
  static const loginButton = 'Giriş ';
  static const loginDontHave = 'Hala bir hesabınız yok mu? ';
  static const loginRegister = 'Kayıt Ol ';
  static const loginFillAllFields = 'Tüm alanları doldurmalısınınız!';

  // Member Notification

  static const notificationTitle = 'Bildirimler';

  // Member Personal Information Form

  static const formTitle = 'Form Alanı';

  // Member Diet List

  static const dietTitle = 'Diyet Listem';
  static const dietSplashCardText =
      'Diyet listeniz henüz hazır değil, diyetisyeniniz ile iletişime geçebilirsiniz.';

  // Member Profil View

  static const profileTitle = 'Profil';

  /// Account Row
  static const profileAccount = 'Hesap';
  static const profilePersonal = 'Kişisel Bilgiler';
  static const profileSuccess = 'Başarılarım';

  /// Other Row
  static const profileOther = 'Diğer';
  static const profileContact = 'Bize Ulaşın';
  static const profilePrivacy = 'Gizlilik Politikası';
  static const profileSettings = 'Ayarlarım';

  /// Notification Row
  static const profileNotification = 'Bildirimler';
  static const profileNotificationOpen = 'Açık';
  static const profileNotificationClose = 'Kapalı';

  // Report Member View
  static const reportTitle = 'Günlük Rapor';
  static const reportGalleryCameraChoose =
      'Öğününüzü galerinizden veya kameranız ile yükleyebilirsiniz.';
  static const reportSplashCardText =
      'Günlük raporlarınız henüz hazır değil, diyetisyeniniz ile iletişime geçebilirsiniz.';

  static const reportGalleryChoose = 'Galeriden Seç';
  static const reportCameraChoose = 'Fotoğraf Çek';

  // Personal Member View
  static const personalMail = 'E-posta';
  static const personalSurname = 'Soyadı';
  static const personalName = 'İsim';
  static const personalID = 'ID';
  static const personalTitle = 'Kişisel Bilgiler';

  // Information Member View
  static const informationSendButton = 'Formu Gönder';
  static const informationFillAll = 'Lütfen tüm alanları doldurun';
  static const informationSuccessView =
      'Kişisel Bilgi Formunuz \nBaşarıyla Gönderildi.';
  static const informationPhotoError = 'Fotoğrafınız yüklenirken hata oluştu';
  static const informationSplashCardText =
      'Kişisel bilgi formunuz henüz hazır değil, diyetisyeniniz ile iletişime geçebilirsiniz.';

  // Client List Dietician View
  static const searchDieticianClientTitle = 'Yeni Danışan Ekle';
  static const searchDieticianLabelText = 'Danışan ID';
  static const searchDieticianCancel = 'İptal';
  static const searchDieticianAdd = 'Ekle';
  static const searchDieticianSend = 'Gönder';
  static const searchDieticianIdAlert = 'Danışan ID girmeyi unuttunuz!.';
  static const searchDieticianDietAlert =
      'Diyet listesi seçimi yapmayı unuttunuz!.';
  static const searchDieticianFormAlert = 'Form seçimi yapmayı unuttunuz!.';
  static const searchDieticianSearchDietHint = 'Diyeti arayın...';
  static const searchDieticianSearchFormHint = 'Formu arayın...';
  static const searchDieticianSearchAppbarTitle = 'Danışan Listesi';
  static const searchDieticianUploadForm = 'Form\nGönder';
  static const searchDieticianAddDiet = 'Diyet\nYaz';
  static const searchDieticianUpdateDiet = 'Diyet\nGüncelle';
  static const searchDieticianFormAnswers = 'Form\nCevapları';

  // Create Diet Dietician View
  static const createDietDieticianTitle = 'Diyet Planı Oluştur';
  static const createDietDieticianAddMeal = 'Öğün Ekle';
  static const createDietDieticianMealName = 'Öğün Adı';
  static const createDietDieticianEnterContent = 'İçerik Ekle';
  static const createDietDieticianContent = 'İçerik ';

  static const createDietDieticianSendDiet = 'Diyeti Gönder';

  // Create Form Dietician View
  static const createFormDieticianFormName = 'Form Adı';
  static const createFormDieticianTitle = 'Form Oluştur';
  static const createFormDieticianAddQuestion = 'Soru Ekle';
  static const createFormDieticianQuestion = 'Soru Metni';
  static const createFormDieticianAddForm = 'Formu Ekle';

  // Delete Form Diet Dietician View
  static const formDieticianTitle = 'Form Yönetimi';

  // Edit Form Dietician View

  static const editFormDieticianTitle = 'Formu Düzenle';
  static const editFormDieticianEditForm = 'Formu Güncelle';

  // Edit Diet Dietician View
  static const editDietDieticianTitle = 'Diyet Planını Düzenle';
  static const editDietDieticianUpdateDiet = 'Diyeti Güncelle';

  // Answers Form Dietician View
  static const answersFormDieticianTitle = 'Formlar ve Cevapları';

  // Daily Report Check Dietician View
  static const dailyReportCheckDieticianTitle = 'Günlük Rapor Kontrol';
  static const dailyReportCheckDate = 'Tarih:';
  static const dailyReportMealCount = 'Öğün Sayısı:';

  // Personal Member View
  static const personalDieticianMail = 'E-posta';
  static const personalDieticianSurname = 'Soyadı';
  static const personalDieticianName = 'İsim';
  static const personalDieticianID = 'ID';
  static const personalDieticianTitle = 'Diyetisyen Kişisel Bilgileri';
}
