import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/models/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:areonix/views/dietician/register_dietician/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

mixin RegisterDieticianMixin<T extends ConsumerStatefulWidget>
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

  GradientButton buildSignupButton(BuildContext context) {
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

        // Get the current date
        final now = DateTime.now();

        final formattedDate = DateFormat('dd-MM-yyyy').format(now);

        final dietician = Trainer(
          mail: email,
          name: name,
          surname: surname,
          password: password,
          totalDay: 10,
          registerDate: formattedDate,
          clientList: const [],
        );

        await ref
            .read(registerTrainerProvider.notifier)
            .registerWithEmailAndPassword(email, password, dietician, context);
      },
    );
  }
}
