import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mixin/daily_report_check_dietician_UI_mixin.dart';
import 'mixin/daily_report_check_dietician_mixin.dart';

class DailyReportCheckDieticianView extends ConsumerStatefulWidget {
  @override
  ConsumerState<DailyReportCheckDieticianView> createState() =>
      _DailyReportCheckDieticianViewState();
}

class _DailyReportCheckDieticianViewState
    extends ConsumerState<DailyReportCheckDieticianView>
    with DailyReportCheckDieticianMixin, DailyReportCheckDieticianUIMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                clientCard(context, ref),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
