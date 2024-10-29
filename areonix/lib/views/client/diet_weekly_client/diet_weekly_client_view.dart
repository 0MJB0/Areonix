import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mixin/diet_weekly_client_UI_mixin.dart';
import 'mixin/diet_weekly_client_mixin.dart'; // MealTimes sınıfını buradan getiriyoruz

class DietWeeklyClient extends ConsumerStatefulWidget {
  const DietWeeklyClient({super.key});

  @override
  _DietWeeklyClientState createState() => _DietWeeklyClientState();
}

class _DietWeeklyClientState extends ConsumerState<DietWeeklyClient>
    with
        DietWeeklyClientMixin<DietWeeklyClient>,
        DietWeeklyClientUIMixin<DietWeeklyClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: dietComponents(context),
      ),
    );
  }
}
