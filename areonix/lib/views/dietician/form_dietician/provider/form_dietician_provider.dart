import 'package:areonix/core/utility/firebase/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../splash_dietician/provider/dietican_provider.dart';
import 'form_card_state.dart';

final formDieticianProvider =
    StateNotifierProvider<FormDieticianNotifier, FormListManagerState>((ref) {
  // DieticianProvider'ın state'inden form bilgilerini alıyoruz
  final dieticianForms = ref.watch(dieticianProvider).dieticianForms ?? {};

  // Formları mapleyerek FormState'e çeviriyoruz
  final initialForms = dieticianForms.entries.map((entry) {
    return DieticianFormState(
      formName: entry.key, // formName, Map'in anahtarıdır
      questions: (entry.value as List<dynamic>)
          .cast<String>(), // questions, Map'in değeridir ve listeye cast edilir
    );
  }).toList();

  // FormDieticianNotifier'ı initialForms ile besliyoruz
  return FormDieticianNotifier(initialForms: initialForms, ref: ref);
});

class FormDieticianNotifier extends StateNotifier<FormListManagerState> {
  FormDieticianNotifier({
    required List<DieticianFormState> initialForms,
    required this.ref,
  }) : super(FormListManagerState(forms: initialForms));

  final Ref ref;

  Future<void> addForm(
    String dieticianId,
    String formName,
    List<String> questions,
    BuildContext context, // Snackbar göstermek için context ekledik
  ) async {
    try {
      // Mevcut form isimlerini kontrol et
      final existingForms = state.forms.map((form) => form.formName).toList();

      // Eğer aynı isimde bir form varsa, hata mesajı göster ve işlemi durdur
      if (existingForms.contains(formName)) {
        showCustomSnackBar(
          context: context,
          message: 'Aynı isimli form ekleme yapılamaz!',
        );
        return; // Aynı isimli form varsa devam etme
      }

      // Yeni form verisini hazırlıyoruz
      final formData = <String, List<String>>{
        formName: questions,
      };

      // Firestore'da formu ekle
      await FirebaseCollections.trainer.reference.doc(dieticianId).set(
        {
          'dietician_forms': formData,
        },
        SetOptions(merge: true),
      );

      showCustomSnackBar(
        context: context,
        message: 'Form başarıyla oluşturuldu!',
      );

      // Yeni formu oluştur
      final newForm = DieticianFormState(
        formName: formName,
        questions: questions,
      );

      // Local state'i güncelle: formu listeye ekle
      state = state.copyWith(forms: [...state.forms, newForm]);

      // State'in güncellenip güncellenmediğini kontrol et
      print("Updated local state: ${state.forms}");

      // Yeni formu ekledikten sonra formları yenile
      await refreshForms(dieticianId);
    } catch (e) {
      print("Error adding form: $e");
    }
  }

  Future<void> updateForm(
    String dieticianId,
    String
        updatedFormName, // Güncellenmiş form adı (aynı zamanda ID olarak kullanılıyor)
    List<String> updatedQuestions, // Güncellenmiş sorular
  ) async {
    try {
      // Güncellenmiş form verisini hazırlıyoruz
      final updatedFormData = <String, List<String>>{
        updatedFormName: updatedQuestions, // Form ismi ve soruları güncellenir
      };

      // Firestore'da formu güncelle
      await FirebaseCollections.trainer.reference.doc(dieticianId).set(
        {
          'dietician_forms': updatedFormData,
        },
        SetOptions(merge: true),
      );

      // Yerel state'deki formu güncelle
      final updatedForm = DieticianFormState(
        formName: updatedFormName,
        questions: updatedQuestions, // Güncellenmiş soru listesi
      );

      // Yerel state'teki formu bul ve güncelle
      final updatedForms = state.forms.map((form) {
        if (form.formName == updatedFormName) {
          // Form bulunduysa, güncellenmiş formu yerleştir
          return updatedForm;
        }
        return form; // Diğer formları aynen bırak
      }).toList();

      // Yerel state'i güncelle: forms listesini güncellenmiş halleriyle yenile
      state = state.copyWith(forms: updatedForms);

      // State'in güncellenip güncellenmediğini kontrol et
      print("Updated local state: ${state.forms}");

      // Güncellenen formları yenile
      await refreshForms(dieticianId);
    } catch (e) {
      print("Error updating form: $e");
    }
  }

  Future<void> deleteForm(String formName, String dieticianId) async {
    try {
      // Local olarak formu kaldır
      state = state.copyWith(
        forms: state.forms.where((form) => form.formName != formName).toList(),
      );

      print("Form '$formName' diyetisyen '$dieticianId' için siliniyor.");

      // Firestore'da dieticianForms alanını güncelle
      await FirebaseCollections.trainer.reference.doc(dieticianId).update({
        'dietician_forms.$formName': FieldValue.delete(),
      });

      print("Form '$formName' veritabanından başarıyla silindi.");

      // Dietician state'ini güncelle
      await refreshForms(dieticianId);
    } catch (e) {
      print("Form silinirken hata oluştu: $e");
    }
  }

  Future<void> refreshForms(String dieticianId) async {
    try {
      // Diyetisyen bilgilerini Firestore'dan çek
      await ref.read(dieticianProvider.notifier).fetchAndLoad();
      final formsMap = ref.read(dieticianProvider).dieticianForms ?? {};

      // FormState nesnelerine dönüştür
      final updatedForms = formsMap.entries.map((entry) {
        return DieticianFormState(
          formName: entry.key.replaceAll('_', ' '),
          questions: (entry.value as List<dynamic>).cast<String>(),
        );
      }).toList();

      // State'i güncelleyerek UI'nin güncellenmesini sağla
      state = state.copyWith(
        forms: updatedForms,
      );
      print("Forms refreshed: $updatedForms");
    } catch (e) {
      print("Error refreshing forms: $e");
    }
  }

  Future<void> updateDieticianForms(String dieticianId) async {
    final dieticianNotifier = ref.read(dieticianProvider.notifier);
    await dieticianNotifier.fetchDieticianInformation();
  }

  void filterForms(String query) {
    if (query.isEmpty) {
      state = state.copyWith(searchingForms: false); // Arama yapılmıyorsa false
    } else {
      final filteredForms = state.forms.where((form) {
        final formName = form.formName?.toLowerCase() ?? '';
        final lowerCaseQuery = query.toLowerCase();
        return formName.contains(lowerCaseQuery);
      }).toList();

      state = state.copyWith(
        filteredForms: filteredForms,
        searchingForms: true,
      ); // Arama yapılıyorsa true
    }
  }
}
