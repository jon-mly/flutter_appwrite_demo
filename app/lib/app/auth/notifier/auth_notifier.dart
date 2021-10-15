import 'package:appwrite_demo/app/auth/auth_state.dart';
import 'package:appwrite_demo/services/auth/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({required IAuthService service})
      : _service = service,
        super(AuthState.initial());

  final IAuthService _service;

  //
  // Auth
  //

  Future<void> login(String email, String password) async {
    state = state.copyWith(loginStatus: AuthRequestStatus.loading);
    try {
      await _service.login(email, password).then((bool loggedIn) {
        if (loggedIn) {
          state = state.copyWith(
              loginStatus: AuthRequestStatus.success,
              authStatus: AuthStatus.authenticated);
        } else {
          state = state.copyWith(
              loginStatus: AuthRequestStatus.failed,
              authStatus: AuthStatus.unauthenticated);
        }
      });
    } catch (e) {
      state = state.copyWith(loginStatus: AuthRequestStatus.failed);
      // Error handling to set up
    }
  }

  Future<void> signUp(String email, String password) async {
    state = state.copyWith(signUpStatus: AuthRequestStatus.loading);
    try {
      await _service.signUp(email, password).then((bool loggedIn) {
        if (loggedIn) {
          state = state.copyWith(
              signUpStatus: AuthRequestStatus.success,
              authStatus: AuthStatus.authenticated);
        } else {
          state = state.copyWith(
              signUpStatus: AuthRequestStatus.failed,
              authStatus: AuthStatus.unauthenticated);
        }
      });
    } catch (e) {
      state = state.copyWith(signUpStatus: AuthRequestStatus.failed);
      // Error handling to set up
    }
  }
}
