class AuthState {
  String? email;
  String? password;
  bool isLoading = false;

  AuthState({this.email, this.password, this.isLoading = false});

  factory AuthState.initial() => AuthState();
}
