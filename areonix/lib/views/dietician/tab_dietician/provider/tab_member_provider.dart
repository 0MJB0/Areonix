import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabDieticianState {
  final int currentIndex;

  TabDieticianState({this.currentIndex = 0});

  TabDieticianState copyWith({int? currentIndex}) {
    return TabDieticianState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

class TabMemberNotifier extends StateNotifier<TabDieticianState> {
  TabMemberNotifier() : super(TabDieticianState());

  void updateIndex(int newIndex) {
    state = state.copyWith(currentIndex: newIndex);
  }
}

final tabMemberProvider =
    StateNotifierProvider<TabMemberNotifier, TabDieticianState>(
  (ref) => TabMemberNotifier(),
);
