import 'package:flutter/material.dart';

enum ImageConstants {
  imageDietician('dietician'),
  imageMember('member'),
  imageLogo('dietracker');

  final String value;
  const ImageConstants(this.value);

  String get toImg => 'assets/image/img_$value.png';
  Image get toImage => Image.asset(toImg);
  String get toLogo => 'assets/logo/$value.png';
  Image get Logo => Image.asset(toLogo);
}
