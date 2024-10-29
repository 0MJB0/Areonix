import 'package:areonix/core/constants/color/color_constants.dart';
import 'package:areonix/core/constants/string/responsiveness.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'create_form_dietician_mixin.dart';

mixin CreateFormDieticianUIMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T>, CreateFormDieticianMixin<T> {
  CommonAppbar appBar(BuildContext context) {
    return const CommonAppbar(
      title: StringConstants.createFormDieticianTitle,
    );
  }

  Widget buildFormNameField() {
    return SizedBox(
      width: kIsWeb
          ? Responsiveness.createFormNameWeb.w
          : Responsiveness.createFormNameMobile.w,
      child: RoundTextFormField(
        controller: formNameController,
        labelText: StringConstants.createFormDieticianFormName,
        icon: Icons.description,
        iconColor: TColor.airforce,
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget buildAddQuestionButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: TColor.airforce,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: addQuestion,
      icon: Icon(
        Icons.add,
        color: TColor.black,
      ),
      label: kIsWeb
          ? const WebText(text: StringConstants.createFormDieticianAddQuestion)
          : BoldText(
              text: StringConstants.createFormDieticianAddQuestion,
              color: TColor.black,
            ),
    );
  }

  Widget buildQuestionCard(int questionIndex) {
    return SizedBox(
      width: kIsWeb
          ? Responsiveness.createFormQuestionWeb
          : Responsiveness.createFormQuestionMobile,
      child: Card(
        color: TColor.grey,
        margin: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: TColor.airforce, width: 2),
        ),
        elevation: 5,
        shadowColor: TColor.airforce.withOpacity(0.5),
        child: Padding(
          padding: context.padding.normal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundTextFormField(
                labelText: StringConstants.createFormDieticianQuestion,
                icon: Icons.edit,
                iconColor: TColor.airforce,
                onChanged: (value) {
                  setState(() {
                    questions[questionIndex] = value;
                  });
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    removeQuestion(questionIndex);
                  },
                  icon: Icon(Icons.delete, color: TColor.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSendFormButton() {
    return Container(
      padding: context.padding.normal,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: TColor.airforce,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: sendForm,
        child: kIsWeb
            ? const WebText(text: StringConstants.createFormDieticianAddForm)
            : BoldText(
                text: StringConstants.createFormDieticianAddForm,
                color: TColor.black,
              ),
      ),
    );
  }

  Widget buildFormList(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: kIsWeb
                ? Responsiveness.createFormCardWeb.w
                : Responsiveness.createFormCardMobile.w,
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return buildQuestionCard(index);
                  },
                ),
                context.sized.emptySizedHeightBoxLow,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
