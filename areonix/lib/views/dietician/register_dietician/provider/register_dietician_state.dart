class TrainerDieticianState {
  final bool isCheck;
  final bool isVisible;

  TrainerDieticianState({this.isCheck = false, this.isVisible = false});

  TrainerDieticianState copyWith({bool? isCheck, bool? isVisible}) {
    return TrainerDieticianState(
      isCheck: isCheck ?? this.isCheck,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
