import 'package:areonix/core/constants/string/route_constants.dart';
import 'package:areonix/views/dietician/splash_dietician/provider/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

mixin SplashMemberMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  Future<void> loadData() async {
    try {
      // Verileri yükle ve eski dosyaları sil
      await ref.read(dieticianProvider.notifier).fetchAndLoad();
      navigateToNextScreen();
    } catch (e) {
      print('Error during data load: $e');
      // Hata durumunda kullanıcıya bir mesaj gösterebilir veya başka bir işlem yapabilirsiniz
    }
  }

  void navigateToNextScreen() {
    // Veriler yüklendikten sonra ana ekrana geçiş yap
    context.route.navigateToReset(RouteConstant.homeDietician);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(loadData);
  }
}
