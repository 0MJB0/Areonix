import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AddClientDialog extends StatefulWidget {
  final TextEditingController idController;
  final List<String> clients;
  final VoidCallback onUpdate;

  const AddClientDialog({
    Key? key,
    required this.idController,
    required this.clients,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _AddClientDialogState createState() => _AddClientDialogState();
}

class _AddClientDialogState extends State<AddClientDialog> {
  int remainingCharacters = 28;

  @override
  void initState() {
    super.initState();
    widget.idController.addListener(_updateRemainingCharacters);
  }

  @override
  void dispose() {
    widget.idController.removeListener(_updateRemainingCharacters);
    super.dispose();
  }

  void _updateRemainingCharacters() {
    setState(() {
      remainingCharacters = 28 - widget.idController.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final radius = WidgetSize.dialogRadius.value;
    final width = WidgetSize.dialogWidth.value;
    return AlertDialog(
      title: Center(
        child: kIsWeb
            ? const WebAppbarText(
                text: StringConstants.searchDieticianClientTitle,
              )
            : BoldText(
                text: StringConstants.searchDieticianClientTitle,
                textStyle: context.general.textTheme.titleLarge,
              ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            cursorColor: TColor.airforce,
            controller: widget.idController,
            maxLength: 28,
            decoration: InputDecoration(
              labelText: StringConstants.searchDieticianLabelText,
              labelStyle: context.general.textTheme.bodySmall
                  ?.copyWith(color: TColor.airforce),
              prefixIcon: Icon(
                Icons.person,
                color: TColor.airforce,
              ),
              filled: true,
              fillColor: TColor.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(
                  color: TColor.airforce,
                  width: width,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(
                  color: TColor.airforce,
                  width: width,
                ),
              ),
              contentPadding: context.padding.normal,
              counterText:
                  '${widget.idController.text.length}/28', // Karakter sayısını 0/28 gibi gösterir
            ),
          ),
          context.sized.emptySizedHeightBoxLow
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
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: context.padding.verticalLow,
                      child: kIsWeb
                          ? const WebText(
                              text: StringConstants.searchDieticianCancel,
                            )
                          : const BoldText(
                              text: StringConstants.searchDieticianCancel,
                            ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if (widget.idController.text.length == 28) {
                        widget.onUpdate();
                        widget.idController.clear();
                        Navigator.of(context).pop();
                      } else {
                        // Hata mesajını göster
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Geçersiz ID: ID 28 karakter uzunluğunda olmalıdır.',
                            ),
                            backgroundColor: TColor.airforce,
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: context.padding.verticalLow,
                      child: kIsWeb
                          ? const WebText(
                              text: StringConstants.searchDieticianAdd,
                            )
                          : const BoldText(
                              text: StringConstants.searchDieticianAdd,
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
