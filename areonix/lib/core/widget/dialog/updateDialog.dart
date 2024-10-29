import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/alert_dialog_constants.dart';
import 'package:flutter/material.dart';

class UpdateDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const UpdateDialog.UpdateDialog({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: TColor.airforce,
      title: const Text(
        AlertDialogConstants.updateTitle,
      ),
      content: const Text(AlertDialogConstants.updateContent),
      actions: [
        TextButton(
          onPressed: onConfirm,
          child: Text(
            AlertDialogConstants.updateButton,
            style: TextStyle(color: TColor.black),
          ),
        ),
      ],
    );
  }
}
