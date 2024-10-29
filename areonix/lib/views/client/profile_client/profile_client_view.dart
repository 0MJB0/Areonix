import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../../../core/constants/index.dart';
import 'mixin/profile_client_UI_mixin.dart';
import 'mixin/profile_client_mixin.dart';

class ProfileClientView extends StatefulWidget {
  const ProfileClientView({super.key});

  @override
  State<ProfileClientView> createState() => _ProfileClientViewState();
}

class _ProfileClientViewState extends State<ProfileClientView>
    with ProfileClientMixin, ProfileClientUIMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context), // Added with Mixin
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: context.padding.medium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              context.sized.emptySizedHeightBoxLow,
              buildAccountColumn(context), // Added with Mixin
              context.sized.emptySizedHeightBoxNormal,
              buildOtherColumn(context), // Added with Mixin
            ],
          ),
        ),
      ),
    );
  }
}
