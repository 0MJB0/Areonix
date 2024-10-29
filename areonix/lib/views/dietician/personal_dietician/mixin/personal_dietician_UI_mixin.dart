import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:areonix/views/dietician/splash_dietician/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'personal_dietician_mixin.dart';

mixin PersonalDieticianUIMixin on PersonalDieticianMixin {
  PersonalClientViewCard mailCard(BuildContext context, WidgetRef ref) {
    final clientMail = ref.watch(dieticianProvider).mail;
    return PersonalClientViewCard(
      title: StringConstants.personalDieticianMail,
      subtitle: clientMail ?? ' ',
      iconData: Icons.mail,
    );
  }

  PersonalClientViewCard surnameCard(BuildContext context, WidgetRef ref) {
    final clientSurname = ref.watch(dieticianProvider).surname;
    return PersonalClientViewCard(
      title: StringConstants.personalDieticianSurname,
      subtitle: clientSurname ?? ' ',
      iconData: Icons.person_outline,
    );
  }

  PersonalClientViewCard nameCard(BuildContext context, WidgetRef ref) {
    final clientName = ref.watch(dieticianProvider).name;
    return PersonalClientViewCard(
      title: StringConstants.personalDieticianName,
      subtitle: clientName ?? ' ',
      iconData: Icons.person,
    );
  }

  PersonalClientViewCard idCard(BuildContext context, WidgetRef ref) {
    final clientId = ref.watch(dieticianProvider).id;
    return PersonalClientViewCard(
      title: StringConstants.personalDieticianID,
      subtitle: clientId ?? ' ',
      iconData: Icons.security,
      trailing: const Icon(Icons.copy),
      onTrailingPressed: () {
        if (clientId != null) {
          copyToClipboard(context, clientId);
        }
      },
    );
  }

  CommonAppbar appbarPersonalMemberView() {
    return const CommonAppbar(
      title: StringConstants.personalDieticianTitle,
      leading: SizedBox.shrink(),
    );
  }
}
