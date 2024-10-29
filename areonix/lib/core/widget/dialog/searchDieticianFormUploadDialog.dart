import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/enums/index.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class FormUploadDialog extends StatelessWidget {
  const FormUploadDialog({
    required this.clientName,
    required this.dropdownFormSearchFieldController,
    required this.getFormSuggestions,
    this.onSendPressed,
    super.key,
  });
  final String clientName;
  final TextEditingController dropdownFormSearchFieldController;
  final Future<List<String>> Function(String) getFormSuggestions;
  final VoidCallback? onSendPressed;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(
      WidgetSize.dialogRadius.value,
    );
    final width = WidgetSize.dialogWidth.value;
    return AlertDialog(
      title: Center(
        child: kIsWeb
            ? WebAppbarText(text: clientName)
            : BoldText(
                text: clientName,
                textStyle: context.general.textTheme.titleLarge,
              ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            child: Column(
              children: [
                context.sized.emptySizedHeightBoxLow3x,
                DropDownSearchFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    cursorColor: TColor.airforce,
                    decoration: InputDecoration(
                      labelText: StringConstants.searchDieticianUploadForm,
                      labelStyle: context.general.textTheme.bodySmall
                          ?.copyWith(color: TColor.airforce),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide: BorderSide(
                          color: TColor.airforce,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide: BorderSide(
                          color: TColor.airforce,
                          width: width,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.upload_file,
                        color: TColor.airforce,
                      ),
                      hintText: StringConstants.searchDieticianSearchFormHint,
                      hintStyle: context.general.textTheme.bodySmall
                          ?.copyWith(color: TColor.grey),
                    ),
                    controller: dropdownFormSearchFieldController,
                  ),
                  suggestionsCallback: getFormSuggestions,
                  itemBuilder: (context, String suggestion) {
                    return ListTile(
                      title: WebText(text: suggestion),
                    );
                  },
                  onSuggestionSelected: (String suggestion) {
                    dropdownFormSearchFieldController.text = suggestion;
                  },
                ),
              ],
            ),
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
                    onPressed: onSendPressed,
                    child: Padding(
                      padding: context.padding.verticalLow,
                      child: kIsWeb
                          ? const WebText(
                              text: StringConstants.searchDieticianSend,
                            )
                          : const BoldText(
                              text: StringConstants.searchDieticianSend,
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
