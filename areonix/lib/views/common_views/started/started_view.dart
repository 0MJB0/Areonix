import 'package:areonix/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mixin/index.dart';

class StartedView extends ConsumerStatefulWidget {
  const StartedView({super.key});

  @override
  ConsumerState<StartedView> createState() => _StartedViewState();
}

class _StartedViewState extends ConsumerState<StartedView>
    with StartedViewMixin, StartedViewUIMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(flex: 3),

            // Ekranın ortasında başlık
            buildStartedTitle(context), // Mixin'den gelen başlık

            // Internet Connection Check
            isConnectedInternet(context),
            // Update App Check
            updateLogic(context),

            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
