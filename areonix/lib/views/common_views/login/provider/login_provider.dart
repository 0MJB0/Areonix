import 'package:areonix/core/widget/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_state.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? userType; // Kullanıcı tipi için değişken

  void changeVisibility() {
    state = state.copyWith(isVisible: !state.isVisible);
  }

  void toggleCheck() {
    state = state.copyWith(isCheck: !state.isCheck);
  }

  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: '');
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null && !user.emailVerified) {
        // E-posta doğrulaması yapılmadıysa kullanıcıya uyarı verelim
        state = state.copyWith(
            isLoading: false,
            errorMessage:
                'E-posta adresiniz doğrulanmamış. Lütfen doğrulama yapın.');

        // Doğrulama e-postasını tekrar gönderelim
        await user.sendEmailVerification();
        showCustomSnackBar(
          context: context,
          message:
              'Doğrulama e-postası gönderildi. Lütfen e-postanızı kontrol edin.',
        );
        return;
      }

      final userId = user?.uid ?? '';

      // Kullanıcının tipini kontrol et
      await _checkUserType(userId);

      state = state.copyWith(isLoading: false);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Bu e-posta adresine sahip kullanıcı bulunamadı.';
        case 'wrong-password':
          errorMessage = 'Şifre hatalı. Lütfen tekrar deneyin.';
        case 'invalid-email':
          errorMessage =
              'Geçersiz e-posta adresi. Lütfen doğru formatta girin.';
        case 'user-disabled':
          errorMessage = 'Bu hesap devre dışı bırakılmıştır.';
        default:
          errorMessage = 'Bir hata oluştu. Lütfen tekrar deneyin.';
      }

      state = state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
      );
    }
  }

  Future<void> _checkUserType(String userId) async {
    final clientDoc = await _firestore.collection('client').doc(userId).get();
    if (clientDoc.exists) {
      userType = 'client';
    } else {
      final dieticianDoc =
          await _firestore.collection('trainer').doc(userId).get();
      if (dieticianDoc.exists) {
        userType = 'trainer';
      } else {
        userType = null;
      }
    }
  }
}
