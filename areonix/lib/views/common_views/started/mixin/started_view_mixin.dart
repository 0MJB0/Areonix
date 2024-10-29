import 'package:areonix/core/constants/string/route_constants.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/dialog/index.dart';
import 'package:areonix/views/common_views/started/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

mixin StartedViewMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  void navigateToNextPage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.route.navigateName(RouteConstant.loginView);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(startedProvider.notifier)
          .checkVersionWithCheckInternetConnnection(
            StringConstants.appVersion,
          );
    });
  }

  void showUpdateDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return UpdateDialog.UpdateDialog(
          onConfirm: () {
            Navigator.of(context).pop();
            SystemNavigator.pop();
          },
        );
      },
    );
  }

  void showInternetNotConnectedDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return InternetNotConnectedDialog.InternetNotConnectedDialog(
          onConfirm: () {
            Navigator.of(context).pop();
            SystemNavigator.pop();
          },
        );
      },
    );
  }
}
