import 'package:flutter/material.dart';

@immutable
class AlertDialogConstants {
  // Update Dialog
  static const String updateTitle = 'Güncelleme Gerekli';
  static const String updateContent =
      'Uygulamayı kullanmaya devam edebilmek için güncelleme gereklidir. Lütfen güncelleyin ve uygulamayı yeniden başlatın.';
  static const String updateButton = 'TAMAM';

  static const continueToApp = 'Uygulamaya devam et';

  // Internet Not Connected Dialog
  static const String internetNotConnectedTitle = 'Internet Bağlantı Hatası ';
  static const String internetNotConnectedContent =
      'Uygulamayı kullanmaya devam edebilmek için internet bağlantınız gereklidir. Lütfen internet bağlantınızı yapın ve uygulamayı yeniden başlatın.';
  static const String internetNotConnectedButton = 'TAMAM';

  static const internetNotConnectedcontinueToApp = 'Uygulamaya devam et';

  // Confirm Delete Form Dialog
  static const String confirmDeleteTitle = 'ONAY';
  static const String confirmDeleteContent =
      'Bu formunuzu silmek \nistediğinize emin misiniz?';
  static const String confirmDeleteCancel = 'İptal';
  static const String confirmDeleteConfirm = 'Evet';

  // Confirm Delete Client Dialog
  static const String confirmClientListDeleteTitle = 'ONAY';
  static const String confirmClientListDeleteContent =
      'Bu danışanınızı silmek \nistediğinize emin misiniz?';
  static const String confirmClientListDeleteCancel = 'İptal';
  static const String confirmClientListDeleteConfirm = 'Evet';

  // Confirm Delete Client Form Answers Dialog
  static const String confirmClientFormAnswersDeleteTitle = 'ONAY';
  static const String confirmClientFormAnswersDeleteContent =
      'Bu formun cevaplarını silmek \nistediğinize emin misiniz?';
  static const String confirmClientFormAnswersCancel = 'İptal';
  static const String confirmClientFormAnswersConfirm = 'Evet';
}
