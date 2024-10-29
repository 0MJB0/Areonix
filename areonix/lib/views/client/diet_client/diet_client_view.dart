import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mixin/index.dart';

class DietClientView extends ConsumerStatefulWidget {
  @override
  _DietClientViewState createState() => _DietClientViewState();
}

class _DietClientViewState extends ConsumerState<DietClientView>
    with DietClientMixin<DietClientView>, DietClientUIMixin<DietClientView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [
          getSizedBoxBasedOnMealTimesLength(context),
          Expanded(
            child: Center(
              child: buildCardStackWidget(context),
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
