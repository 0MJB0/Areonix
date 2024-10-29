class StartedState {
  final bool isRequiredForceUpdate;
  final bool isRedirectLogin;
  final bool isConnectedInternet;

  StartedState({
    this.isRequiredForceUpdate = false,
    this.isRedirectLogin = false,
    this.isConnectedInternet = true,
  });

  StartedState copyWith({
    bool? isRequiredForceUpdate,
    bool? isRedirectHome,
    bool? isConnectedInternet,
  }) {
    return StartedState(
      isRequiredForceUpdate:
          isRequiredForceUpdate ?? this.isRequiredForceUpdate,
      isRedirectLogin: isRedirectHome ?? this.isRedirectLogin,
      isConnectedInternet: isConnectedInternet ?? this.isConnectedInternet,
    );
  }
}
