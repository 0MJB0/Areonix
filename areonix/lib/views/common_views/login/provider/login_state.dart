class LoginState {
  final bool isCheck;
  final bool isVisible;
  final bool isLoading;
  final String errorMessage;

  LoginState({
    this.isCheck = false,
    this.isVisible = false,
    this.isLoading = false,
    this.errorMessage = '',
  });

  LoginState copyWith({
    bool? isCheck,
    bool? isVisible,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LoginState(
      isCheck: isCheck ?? this.isCheck,
      isVisible: isVisible ?? this.isVisible,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
