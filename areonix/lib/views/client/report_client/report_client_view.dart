import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mixin/report_client_UI_mixin.dart';
import 'mixin/report_client_mixin.dart';

class ReportClientView extends ConsumerStatefulWidget {
  const ReportClientView({super.key});

  @override
  _ReportClientViewState createState() => _ReportClientViewState();
}

class _ReportClientViewState extends ConsumerState<ReportClientView> with ReportClientMixin, ReportClientUIMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildReportCards(context),
    );
  }
}
