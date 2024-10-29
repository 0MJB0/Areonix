import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:areonix/views/common_views/started/provider/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import 'started_view_mixin.dart';

mixin StartedViewUIMixin<T extends ConsumerStatefulWidget>
    on StartedViewMixin<T> {
  AnimatedTextKit buildStartedTitle(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        WavyAnimatedText(
          'DIETRACKER',
          textStyle: context.general.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
      repeatForever: true,
    );
  }

  Widget isConnectedInternet(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(startedProvider);

        if (state.isConnectedInternet == false) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showInternetNotConnectedDialog(context);
          });
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget updateLogic(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(startedProvider);

        if (state.isRequiredForceUpdate) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showUpdateDialog(context);
          });
        }
        navigateToNextPage(context);
        return const SizedBox.shrink();
      },
    );
  }
}
