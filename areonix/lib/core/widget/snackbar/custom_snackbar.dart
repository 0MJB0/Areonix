import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  const CustomSnackBar({
    required this.context,
    required this.message,
    this.backgroundColor,
    this.duration = const Duration(seconds: 3), // Varsayılan süre 3 saniye
  });

  final BuildContext context;
  final String message;
  final Color? backgroundColor;
  final Duration duration; // Duration parametresi eklendi

  void show() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor ?? TColor.airforce,
        content: NormalText(
          text: message,
        ),
        duration: duration, // Burada sürenin ayarlandığı yer
      ),
    );
  }
}

// Bu fonksiyon CustomSnackBar'ı çağırır ve gösterir
void showCustomSnackBar({
  required BuildContext context,
  required String message,
  Color? backgroundColor,
  Duration duration = const Duration(seconds: 3), // Varsayılan süre 3 saniye
}) {
  CustomSnackBar(
    context: context,
    message: message,
    backgroundColor: backgroundColor,
    duration: duration, // Duration parametresini ilet
  ).show();
}
