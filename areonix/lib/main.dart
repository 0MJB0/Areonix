import 'package:areonix/views/index_route.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/constants/string/string_constants.dart';
import 'core/init/app_theme.dart';
import 'core/init/application_start.dart';
import 'core/routes/routes.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: StringConstants.appName,
          theme: AppTheme(context).theme,
          home: kIsWeb ? const LoginView() : const StartedView(),
          routes: routes,
        );
      },
    );
  }
}
