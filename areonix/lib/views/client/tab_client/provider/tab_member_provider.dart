import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabMemberState {
  final int currentIndex;

  TabMemberState({this.currentIndex = 0});

  TabMemberState copyWith({int? currentIndex}) {
    return TabMemberState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

class TabMemberNotifier extends StateNotifier<TabMemberState> {
  TabMemberNotifier() : super(TabMemberState());

  void updateIndex(int newIndex) {
    state = state.copyWith(currentIndex: newIndex);
  }
}

final tabMemberProvider =
    StateNotifierProvider<TabMemberNotifier, TabMemberState>(
  (ref) => TabMemberNotifier(),
);
