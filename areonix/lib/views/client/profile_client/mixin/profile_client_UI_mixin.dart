import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/route_constants.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:url_launcher/url_launcher.dart';

mixin ProfileClientUIMixin<T extends StatefulWidget> on State<T> {
  ClientAppbar buildAppBar(BuildContext context) {
    return const ClientAppbar(
      title: StringConstants.profileTitle,
    );
  }

  Column buildAccountColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoldText(
          text: StringConstants.profileAccount,
          textStyle: context.general.textTheme.titleMedium,
          color: TColor.black,
        ),
        context.sized.emptySizedHeightBoxLow3x,
        ProfileClientViewCard(
          leadingIcon: Icons.person,
          title: StringConstants.profilePersonal,
          onTap: () {
            context.route.navigateName(RouteConstant.personalMember);
          },
        ),
        context.sized.emptySizedHeightBoxLow3x,
        ProfileClientViewCard(
          leadingIcon: Icons.assignment,
          title: StringConstants.profileSuccess,
          onTap: () {},
        ),
      ],
    );
  }

  Column buildOtherColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoldText(
          text: StringConstants.profileOther,
          textStyle: context.general.textTheme.titleMedium,
          color: TColor.black,
        ),
        context.sized.emptySizedHeightBoxLow3x,
        ProfileClientViewCard(
          leadingIcon: Icons.message,
          title: StringConstants.profileContact,
          onTap: () async {
            final email = 'dogukankarakus_@hotmail.com';
            final subject = 'İletişim Konusu';
            final body = 'Merhaba, benimle iletişime geçmek için buradayım.';

            final mailtoUrl = Uri(
              scheme: 'mailto',
              path: email,
              query:
                  'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
            );

            try {
              if (await canLaunchUrl(mailtoUrl)) {
                await launchUrl(mailtoUrl,
                    mode: LaunchMode.externalApplication);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('E-posta uygulaması bulunamadı'),
                  ),
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('E-posta gönderimi başarısız oldu: $e'),
                ),
              );
            }
          },
        ),
        context.sized.emptySizedHeightBoxLow3x,
        ProfileClientViewCard(
          leadingIcon: Icons.security,
          title: StringConstants.profilePrivacy,
          onTap: () {},
        ),
        context.sized.emptySizedHeightBoxLow3x,
        ProfileClientViewCard(
          leadingIcon: Icons.settings,
          title: StringConstants.profileSettings,
          onTap: () {},
        ),
      ],
    );
  }
}
