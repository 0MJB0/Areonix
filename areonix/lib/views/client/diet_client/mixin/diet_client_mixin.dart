import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../splash_client/provider/client_provider.dart';

mixin DietClientMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  List<String> mealTimes = [];
  Map<String, List<String>> mealDetails = {};

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    final clientState = ref.read(clientProvider);

    setState(() {
      mealTimes = clientState.currentDayMealTimes ?? [];
      mealDetails = clientState.mealDetails ?? {};
    });
  }
}
