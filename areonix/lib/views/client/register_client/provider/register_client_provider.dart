import 'package:areonix/core/constants/string/route_constants.dart';
import 'package:areonix/core/models/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class RegisterClientState {
  final bool isCheck;
  final bool isVisible;

  RegisterClientState({this.isCheck = false, this.isVisible = false});

  RegisterClientState copyWith({bool? isCheck, bool? isVisible}) {
    return RegisterClientState(
      isCheck: isCheck ?? this.isCheck,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

class RegisterClientNotifier extends StateNotifier<RegisterClientState> {
  RegisterClientNotifier() : super(RegisterClientState());

  void changeVisibility() {
    state = state.copyWith(isVisible: !state.isVisible);
  }

  void toggleCheck() {
    state = state.copyWith(isCheck: !state.isCheck);
  }

  Future<void> registerWithEmailAndPassword(String email, String password,
      Client client, BuildContext context) async {
    try {
      final authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = authResult.user;

      if (user != null) {
        final userId = user.uid;

        // Client modeline kullanıcı ID'sini ekle
        final updatedClient = client.copyWith(id: userId, dietician: null);
        await saveClientToFirestore(updatedClient);

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

  Future<void> saveClientToFirestore(Client client) async {
    final docRef =
        FirebaseFirestore.instance.collection('client').doc(client.id);
    await docRef.set(client.toJson());
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

final registerMemberProvider =
    StateNotifierProvider<RegisterClientNotifier, RegisterClientState>(
  (ref) => RegisterClientNotifier(),
);
