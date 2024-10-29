import 'package:areonix/views/dietician/demo_dietician/demo.dart';
import 'package:areonix/views/dietician/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../client/tab_client/provider/tab_member_provider.dart';

class HomeDieticianView extends ConsumerWidget {
  const HomeDieticianView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabMemberState = ref.watch(tabMemberProvider);
    final tabMemberNotifier = ref.read(tabMemberProvider.notifier);

    return Scaffold(
      body: IndexedStack(
        index: tabMemberState.currentIndex,
        children: [
          ClientListDieticianView(),
          DailyReportCheckDieticianView(),
          const FormDieticianView(),
          const PersonalDieticianView(),
          const DemoView(),
        ],
      ),
      bottomNavigationBar: TabDieticianView(
        currentIndex: tabMemberState.currentIndex,
        onTap: tabMemberNotifier.updateIndex,
      ),
    );
  }
}
