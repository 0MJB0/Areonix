import 'package:areonix/views/client/index.dart';
import 'package:areonix/views/client/tab_client/provider/tab_member_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeMemberView extends ConsumerWidget {
  const HomeMemberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabMemberState = ref.watch(tabMemberProvider);
    final tabMemberNotifier = ref.read(tabMemberProvider.notifier);

    return Scaffold(
      body: IndexedStack(
        index: tabMemberState.currentIndex,
        children: const [
          DietWeeklyClient(),
          ReportClientView(),
          FormClientView(),
          PersonalClientView(),
        ],
      ),
      bottomNavigationBar: TabClientView(
        currentIndex: tabMemberState.currentIndex,
        onTap: tabMemberNotifier.updateIndex,
      ),
    );
  }
}
