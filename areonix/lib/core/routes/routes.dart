import 'package:areonix/core/constants/string/route_constants.dart';
import 'package:flutter/material.dart';

import '../../views/index_route.dart';

final Map<String, WidgetBuilder> routes = {
  RouteConstant.homeMember: (context) => const HomeMemberView(),
  RouteConstant.personalMember: (context) => const PersonalClientView(),
  RouteConstant.changePasswordView: (context) => const ChangePasswordView(),
  RouteConstant.loginView: (context) => const LoginView(),
  RouteConstant.chooseView: (context) => const ChooseView(),
  RouteConstant.homeDietician: (context) => const HomeDieticianView(),
  RouteConstant.createDietDietician: (context) =>
      const CreateDietDieticianView(),
  RouteConstant.createFormDietician: (context) =>
      const CreateFormDieticianView(),
  RouteConstant.formDietician: (context) => const FormDieticianView(),
  RouteConstant.editFormDietician: (context) => const EditFormDieticianView(),
  RouteConstant.clientListDietician: (context) => ClientListDieticianView(),
  RouteConstant.editDietDietician: (context) => const EditDietDieticianView(),
  RouteConstant.answersFormDietician: (context) =>
      const FormAnswersDieticianView(),
  RouteConstant.dailyReportCheckDietician: (context) =>
      DailyReportCheckDieticianView(),
  RouteConstant.dailyReportDetailsDietician: (context) =>
      const DailyReportDetailsDietician(),
  RouteConstant.splashMember: (context) => SplashClientView(),
  RouteConstant.splashDietician: (context) => SplashDieticianView(),
};
