import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/alert_dialog_constants.dart';
import 'package:flutter/material.dart';

class InternetNotConnectedDialog extends StatelessWidget {
  const InternetNotConnectedDialog.InternetNotConnectedDialog({
    required this.onConfirm,
    super.key,
  });
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: TColor.airforce,
      title: const Text(
        AlertDialogConstants.internetNotConnectedTitle,
      ),
      content: const Text(AlertDialogConstants.internetNotConnectedContent),
      actions: [
        TextButton(
          onPressed: onConfirm,
          child: Text(
            AlertDialogConstants.internetNotConnectedButton,
            style: TextStyle(color: TColor.black),
          ),
        ),
      ],
    );
  }
}
