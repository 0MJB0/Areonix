import 'package:areonix/core/constants/string/route_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:areonix/views/common_views/login/provider/index.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

mixin LoginViewMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login(BuildContext context, WidgetRef ref) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    await ref.read(loginProvider.notifier).loginUser(email, password, context);

    // LoginNotifier'daki userType değişkenini kontrol edelim
    final userType = ref.read(loginProvider.notifier).userType;

    if (userType == 'client') {
      kIsWeb
          ? showCustomSnackBar(
              context: context,
              message: 'Mobil uygulamadan giriş yapınız!',
            )
          : await context.route.navigateToReset(RouteConstant.splashMember);
    } else if (userType == 'trainer') {
      await context.route.navigateToReset(RouteConstant.splashDietician);
    } else {
      // Hata mesajını gösterelim
      final errorMessage = ref.read(loginProvider).errorMessage;
      if (errorMessage.isNotEmpty) {
        showCustomSnackBar(
          context: context,
          message: errorMessage,
        );
      }
    }
  }
}
