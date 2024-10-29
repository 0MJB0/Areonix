import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/models/client.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:areonix/views/client/register_client/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin RegisterClientMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  GradientButton signupButton(BuildContext context) {
    return GradientButton(
      text: StringConstants.signUpRegister,
      onPressed: () async {
        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        final name = nameController.text.trim();
        final surname = surnameController.text.trim();

        if (email.isEmpty ||
            password.isEmpty ||
            name.isEmpty ||
            surname.isEmpty) {
          return;
        }

        final client = Client(
          mail: email,
          name: name,
          surname: surname,
          password: password,
        );

        await ref
            .read(registerMemberProvider.notifier)
            .registerWithEmailAndPassword(email, password, client, context);
      },
    );
  }
}
