import 'package:areonix/core/constants/string/route_constants.dart';
import 'package:areonix/views/client/splash_client/provider/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

mixin SplashClientMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  Future<void> loadData() async {
    try {
      // Verileri yükle ve eski dosyaları sil
      await ref.read(clientProvider.notifier).fetchAndLoad();

      // mealTimes ve dailyDeletedTime değerlerini alıyoruz
      final clientId = ref.read(clientProvider).clientID;
      final mealTimes = ref.read(clientProvider).currentDayMealTimes;
      final dailyDeletedTime = ref.read(clientProvider).dailyDeletedTime;

      // Eğer dailyDeletedTime null değilse raporu sıfırla
      if (dailyDeletedTime != null) {
        await ref.read(clientProvider.notifier).checkAndResetDailyReport(
              clientId!,
              mealTimes!,
              dailyDeletedTime,
            );
      }

      // Sonraki ekrana git
      navigateToNextScreen();
    } catch (e) {
      print('Error during data load: $e');
    }
  }

  void navigateToNextScreen() {
    context.route.navigateToReset(RouteConstant.homeMember);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(loadData);
  }
}
