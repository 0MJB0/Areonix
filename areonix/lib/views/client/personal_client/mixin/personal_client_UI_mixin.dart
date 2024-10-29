import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:areonix/views/client/personal_client/mixin/personal_client_mixin.dart';
import 'package:areonix/views/client/splash_client/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin PersonalClientUIMixin on PersonalClientMixin {
  PersonalClientViewCard mailCard(BuildContext context, WidgetRef ref) {
    final clientMail = ref.watch(clientProvider).clientMail;
    return PersonalClientViewCard(
      title: StringConstants.personalMail,
      subtitle: clientMail ?? ' ',
      iconData: Icons.mail,
    );
  }

  PersonalClientViewCard surnameCard(BuildContext context, WidgetRef ref) {
    final clientSurname = ref.watch(clientProvider).clientSurname;
    return PersonalClientViewCard(
      title: StringConstants.personalSurname,
      subtitle: clientSurname ?? ' ',
      iconData: Icons.person_outline,
    );
  }

  PersonalClientViewCard nameCard(BuildContext context, WidgetRef ref) {
    final clientName = ref.watch(clientProvider).clientName;
    return PersonalClientViewCard(
      title: StringConstants.personalName,
      subtitle: clientName ?? ' ',
      iconData: Icons.person,
    );
  }

  PersonalClientViewCard idCard(BuildContext context, WidgetRef ref) {
    final clientId = ref.watch(clientProvider).clientID;
    return PersonalClientViewCard(
      title: StringConstants.personalID,
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

  ClientAppbar appbarPersonalMemberView() {
    return const ClientAppbar(
      title: StringConstants.personalTitle,
      leading: SizedBox.shrink(),
    );
  }
}
