// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension AuthStateCopyWith on AuthState {
  AuthState copyWith({
    AuthStatus? authStatus,
    Credentials? credentials,
    AuthRequestStatus? loginStatus,
    AuthRequestStatus? signUpStatus,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      credentials: credentials ?? this.credentials,
      loginStatus: loginStatus ?? this.loginStatus,
      signUpStatus: signUpStatus ?? this.signUpStatus,
    );
  }
}
