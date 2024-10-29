import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/alert_dialog_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const ConfirmDeleteDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: TColor.airforce,
      title: Center(
        child: BoldText(
          text: title,
          textStyle: context.general.textTheme.titleLarge,
          color: TColor.white,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NormalText(
            text: content,
            color: Colors.white,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      context.route.pop();
                    },
                    child: Padding(
                      padding: context.padding.verticalLow,
                      child: BoldText(
                        text: AlertDialogConstants.confirmDeleteCancel,
                        color: TColor.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      onConfirm();
                      context.route.pop();
                    },
                    child: Padding(
                      padding: context.padding.verticalLow,
                      child: BoldText(
                        text: AlertDialogConstants.confirmDeleteConfirm,
                        color: TColor.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
