import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/error_constants.dart';
import 'package:areonix/core/constants/string/responsiveness.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:expansion_tile_list/expansion_tile_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'answers_form_dietician_mixin.dart';

mixin FormAnswersDieticianUIMixin<T extends StatefulWidget>
    on State<T>, FormAnswersDieticianMixin<T> {
  Widget buildExpansionTileList(
    BuildContext context,
    Map<String, Map<String, String>> responses,
  ) {
    return Padding(
      padding: context.padding.normal,
      child: SizedBox(
        width: kIsWeb
            ? Responsiveness.answersFormCardWeb.w
            : Responsiveness.answersFormCardMobile.w,
        child: ExpansionTileList(
          tileGapSize: 10,
          children: responses.keys.map<ExpansionTile>((formName) {
            final questionsAndAnswers = responses[formName]!;
            return ExpansionTile(
              title: BoldText(
                text: formName,
                color: TColor.white,
              ),
              backgroundColor: TColor.airforce,
              collapsedBackgroundColor: TColor.airforce,
              iconColor: TColor.white,
              collapsedIconColor: TColor.white,
              children: List.generate(questionsAndAnswers.length, (i) {
                final question = questionsAndAnswers.keys.elementAt(i);
                final answer = questionsAndAnswers[question] ?? 'Cevap yok';
                return InkWell(
                  onLongPress: () {},
                  child: ListTile(
                    title: BoldText(
                      text: '${i + 1}-) $question',
                      color: TColor.black,
                    ), // Soru
                    subtitle: NormalText(
                      text: '• $answer',
                      color: TColor.white,
                    ), // Cevap
                  ),
                );
              }),
            );
          }).toList(),
        ),
      ),
    );
  }

  CommonAppbar buildAppBar(BuildContext context) {
    return const CommonAppbar(
      title: StringConstants.answersFormDieticianTitle,
    );
  }

  Padding formBuilder(BuildContext context) {
    return Padding(
      padding: context.padding.medium,
      child: FutureBuilder<Map<String, Map<String, String>>?>(
        future: formsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text(ErrorConstants.answersFormSomethingWentWrong));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text(ErrorConstants.answersFormNoAnswersForm),
            );
          }

          // Firestore'dan gelen responses verisi
          final responses = snapshot.data!;

          // Eğer responses yoksa veya boşsa
          if (responses.isEmpty) {
            return const Center(child: Text(ErrorConstants.answersFormNoForm));
          }

          // UI mixin'den alınan ExpansionTileList yapısı
          return buildExpansionTileList(context, responses);
        },
      ),
    );
  }
}
