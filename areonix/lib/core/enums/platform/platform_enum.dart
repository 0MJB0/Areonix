import 'dart:io';

import 'package:flutter/foundation.dart';

enum PlatformEnum {
  android,
  web,
  ios;

  static String get versionName {
    if (Platform.isIOS) {
      return PlatformEnum.ios.name;
    }
    if (Platform.isAndroid) {
      return PlatformEnum.android.name;
    }
    if (kIsWeb) {
      return PlatformEnum.web.name;
    }

    throw Exception('Platform is unused check please!');
  }
}
