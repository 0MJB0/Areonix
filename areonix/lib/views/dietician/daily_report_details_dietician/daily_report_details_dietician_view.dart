import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'mixin/daily_report_details_dietician_UI_mixin.dart';
import 'mixin/daily_report_details_dietician_mixin.dart';

class DailyReportDetailsDietician extends StatefulWidget {
  const DailyReportDetailsDietician({super.key});

  @override
  _DailyReportDetailsDieticianState createState() =>
      _DailyReportDetailsDieticianState();
}

class _DailyReportDetailsDieticianState
    extends State<DailyReportDetailsDietician>
    with DailyReportDetailsDieticianMixin, DailyReportDetailsDieticianUIMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          context.sized.emptySizedHeightBoxHigh,
          chooseMealTime(context), // Sayfa seçme widget'ı
          mealDetails(context), // Detaylar gösterme
        ],
      ),
    );
  }
}
