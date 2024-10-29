import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordNotifier extends StateNotifier<bool> {
  ForgotPasswordNotifier() : super(false);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Şifre sıfırlama (unutulan şifre)
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      state = true; // Şifre sıfırlama e-postası gönderildi
    } on FirebaseAuthException catch (e) {
      print(e.message); // Hataları yönetmek için
      throw Exception(e.message);
    }
  }
}

// ChangePasswordNotifier sağlayıcısı
final changePasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, bool>(
        (ref) => ForgotPasswordNotifier());
