import 'package:areonix/core/constants/index.dart';
import 'package:areonix/core/constants/string/responsiveness.dart';
import 'package:areonix/core/constants/string/string_constants.dart';
import 'package:areonix/core/constants/string/success_constants.dart';
import 'package:areonix/core/widget/index.dart';
import 'package:areonix/views/client/report_client/mixin/report_client_mixin.dart';
import 'package:areonix/views/client/splash_client/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

mixin ReportClientUIMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T>, ReportClientMixin<T> {
  ClientAppbar buildAppBar(BuildContext context) {
    return const ClientAppbar(
      title: StringConstants.reportTitle,
    );
  }

  Widget buildReportCards(BuildContext context) {
    final currentDay = getCurrentDay(); // Mevcut gün
    print("currentDay $currentDay");
    final dailyReportSubmitted =
        ref.watch(clientProvider).dailyReportSubmitted?[currentDay] ??
            {}; // Mevcut günün raporları
    print('dailyReportSubmitted $dailyReportSubmitted');
    // Eğer mevcut günün günlük raporu gönderilmediyse bilgi kartını göster
    if (mealTimes.isEmpty) {
      return const Center(
        child: ClientInfoCard(message: StringConstants.reportSplashCardText),
      );
    }

    // Mevcut günün raporu gönderildiyse, öğün kartlarını göster
    return Padding(
      padding: context.padding.normal,
      child: ListView.builder(
        itemCount: mealTimes.length,
        itemBuilder: (context, index) {
          final mealTime = mealTimes[index];
          final isReported = tempImageUrls[mealTime] != null;
          final isSubmitted = dailyReportSubmitted[mealTime] ?? false;

          // Success message is shown if either isReported or isSubmitted is true
          final showSuccess = isReported || isSubmitted;

          return Column(
            children: [
              if (index == 0)
                context.sized
                    .emptySizedHeightBoxLow3x, // Top padding before the first card
              Padding(
                padding:
                    context.padding.horizontalNormal, // Reduces the card width
                child: InkWell(
                  onTap: () {
                    showMealTimeDialog(context, mealTime);
                  },
                  child: Container(
                    width: Responsiveness.reportClientCardWidthMobile.w,
                    height: Responsiveness.reportClientCardHeightMobile.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 8,
                          left: 8,
                          child: BoldText(
                            text: mealTime,
                            textStyle: context.general.textTheme.bodyLarge,
                          ),
                        ),
                        const Positioned(
                          top: 8,
                          right: 8,
                          child: Icon(Icons.chevron_right),
                        ),
                        if (showSuccess)
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle,
                                    color: TColor.airforce),
                                context.sized.emptySizedHeightBoxLow,
                                NormalText(
                                  text: SuccessConstants.reportSuccessMeal,
                                  color: TColor.airforce,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (index < mealTimes.length - 1)
                SizedBox(
                  height: context.padding.normal.vertical,
                ), // Padding between cards
            ],
          );
        },
      ),
    );
  }

  Future<void> showMealTimeDialog(BuildContext context, String mealTime) async {
    final imageHeight = context.sized.height * 0.3;
    final imageWidth = context.sized.width * 0.8;

    final currentDay = getCurrentDay(); // Mevcut günü al
    final dailyReport =
        ref.watch(clientProvider).dailyReport ?? {}; // Günlük rapor

    // Mevcut güne ait image URL'ini al, dailyReport içinde currentDay ve mealTime'a göre kontrol
    final imageUrl = tempImageUrls[mealTime] ?? dailyReport[mealTime];

    print(
        'Mevcut gün: $currentDay, mealTime: $mealTime, dailyReport: ${dailyReport[mealTime]}');
    print(
        'Mevcut gün raporu: ${dailyReport[currentDay]?[0]}, imageUrl: $imageUrl');

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: BoldText(
              text: mealTime,
              textStyle: context.general.textTheme.titleLarge,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading)
                SizedBox(
                  height: imageHeight,
                  width: imageWidth,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: TColor.airforce,
                    ),
                  ),
                )
              else if (imageUrl != null)
                Image.network(
                  imageUrl,
                  height: imageHeight,
                  width: imageWidth,
                  fit: BoxFit.cover,
                )
              else ...[
                context.sized.emptySizedHeightBoxLow,
                const Text(
                  StringConstants.reportGalleryCameraChoose,
                  textAlign: TextAlign.center,
                ),
                context.sized.emptySizedHeightBoxLow,
              ],
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: TextButton(
                    onPressed: () async {
                      await pickImage(mealTime, ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                    child: const BoldText(
                      text: StringConstants.reportGalleryChoose,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await pickImage(mealTime, ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                  child: const BoldText(
                    text: StringConstants.reportCameraChoose,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
