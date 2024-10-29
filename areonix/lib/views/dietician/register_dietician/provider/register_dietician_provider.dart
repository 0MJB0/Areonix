import 'package:areonix/core/constants/string/route_constants.dart';
import 'package:areonix/core/models/index.dart';
import 'package:areonix/core/utility/firebase/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'register_dietician_state.dart';

class RegisterTrainerNotifier extends StateNotifier<TrainerDieticianState> {
  RegisterTrainerNotifier() : super(TrainerDieticianState());

  void changeVisibility() {
    state = state.copyWith(isVisible: !state.isVisible);
  }

  void toggleCheck() {
    state = state.copyWith(isCheck: !state.isCheck);
  }

  Future<void> registerWithEmailAndPassword(String email, String password,
      Trainer trainer, BuildContext context) async {
    try {
      final authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = authResult.user;

      if (user != null) {
        // Dietician modeline kullanıcı ID'sini ekle
        final userId = user.uid;
        final updatedTrainer = trainer.copyWith(id: userId);

        // Firestore'a kaydet
        await saveTrainerToFirestore(updatedTrainer);

        // Pool collection'ındaki dieticians array'ine ekle
        await addTrainerToPool(userId);

        // E-posta doğrulama bağlantısı gönder
        await user.sendEmailVerification();

        // Kullanıcıyı bilgilendiren SnackBar göster
        showCustomSnackBar(
          context: context,
          message:
              'Doğrulama e-postası gönderildi. Lütfen e-postanızı kontrol edin.',
        );

        // Birkaç saniye bekledikten sonra login sayfasına yönlendir
        await Future<void>.delayed(const Duration(seconds: 2));
        await context.route.navigateToReset(RouteConstant.loginView);
      }
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthError(e, context); // Hataları yönet
    }
  }

  Future<void> saveTrainerToFirestore(Trainer trainer) async {
    final docRef = FirebaseCollections.trainer.reference.doc(trainer.id);
    await docRef.set(trainer.toJson());
  }

  Future<void> addTrainerToPool(String trainerId) async {
    final poolDocRef = FirebaseCollections.pool.reference.doc('1');

    await poolDocRef.update({
      'trainers': FieldValue.arrayUnion([trainerId]),
    });
  }

  // Firebase hatalarını yöneten fonksiyon
  void _handleFirebaseAuthError(FirebaseAuthException e, BuildContext context) {
    String errorMessage;

    switch (e.code) {
      case 'invalid-email':
        errorMessage =
            'Geçersiz e-posta adresi. Lütfen geçerli bir e-posta adresi girin.';
        break;
      case 'user-disabled':
        errorMessage =
            'Bu hesap devre dışı bırakılmış. Destek ekibi ile iletişime geçin.';
        break;
      case 'email-already-in-use':
        errorMessage =
            'Bu e-posta adresi zaten kullanılıyor. Lütfen başka bir e-posta deneyin.';
        break;
      case 'weak-password':
        errorMessage = 'Şifreniz çok zayıf. Lütfen daha güçlü bir şifre seçin.';
        break;
      case 'operation-not-allowed':
        errorMessage =
            'Bu işlem şu anda izin verilmiyor. Lütfen destek ile iletişime geçin.';
        break;
      default:
        errorMessage = 'Kayıt sırasında bir hata oluştu: ${e.message}';
        break;
    }

    showCustomSnackBar(
      context: context,
      message: errorMessage,
    );
  }
}

final registerTrainerProvider =
    StateNotifierProvider<RegisterTrainerNotifier, TrainerDieticianState>(
  (ref) => RegisterTrainerNotifier(),
);
