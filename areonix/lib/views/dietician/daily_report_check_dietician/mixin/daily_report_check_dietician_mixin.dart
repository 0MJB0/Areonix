import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/daily_report_check_dietician_provider.dart';

mixin DailyReportCheckDieticianMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController dropdownFormSearchFieldController =
      TextEditingController();
  final TextEditingController dropdownDietSearchFieldController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    // Sayfa ilk açıldığında client dosyalarını ve bilgilerini çek
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dailyReportCheckDieticianProvider.notifier).refreshClients();
      ref
          .read(dailyReportCheckDieticianProvider.notifier)
          .fetchAllClientsFiles();
    });
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Eğer widget güncellenirse, dosyaları ve client bilgilerini yeniden çek
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dailyReportCheckDieticianProvider.notifier).refreshClients();
      ref
          .read(dailyReportCheckDieticianProvider.notifier)
          .fetchAllClientsFiles();
    });
  }
}
