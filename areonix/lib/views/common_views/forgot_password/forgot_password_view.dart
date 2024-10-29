import 'package:areonix/core/constants/string/route_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import 'provider/forgot_password_provider.dart';

class ChangePasswordView extends ConsumerStatefulWidget {
  const ChangePasswordView({super.key});

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordView> {
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  // Şifre sıfırlama fonksiyonu
  Future<void> _onResetPassword() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await ref
          .read(changePasswordProvider.notifier)
          .resetPassword(_emailController.text);

      // Başarı mesajını SnackBar ile göster
      showCustomSnackBar(
        context: context,
        message: 'Şifre sıfırlama bağlantısı e-posta ile gönderildi.',
      );

      // E-posta gönderimi başarılıysa giriş ekranına yönlendir
      await context.route.navigateToReset(RouteConstant.loginView);
    } catch (e) {
      // Hata mesajını SnackBar ile göster
      showCustomSnackBar(
        context: context,
        message: e.toString(),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        title: 'Şifre Sıfırla',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundTextFormField(
              labelText: 'E-posta (Şifre sıfırlama için)',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              icon: Icons.email,
            ),
            context.sized.emptySizedHeightBoxHigh,
            GradientButton(
              text: 'Şifreyi Sıfırla',
              onPressed: _onResetPassword,
              isLoading: _isLoading, // Yükleme durumu için gerekli parametre
            ),
          ],
        ),
      ),
    );
  }
}
