import 'package:appwrite/models.dart';
import 'package:appwrite_demo/app/auth/data/auth_state.dart';
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

  Future<void> getActiveSession() async {}

  Future<void> login(String email, String password) async {
    state = state.copyWith(loginStatus: AuthRequestStatus.loading);
    try {
      final Session session =
          await _service.createAccountSession(email, password);
      // TODO: save session id
      // TODO: handle data to be retained during the app's lifecycle
      state = state.copyWith(
          loginStatus: AuthRequestStatus.success,
          authStatus: AuthStatus.authenticated);
    } catch (e) {
      state = state.copyWith(loginStatus: AuthRequestStatus.failed);
      // Error handling to set up
    }
  }

  Future<void> signUp(String email, String password) async {
    state = state.copyWith(signUpStatus: AuthRequestStatus.loading);
    try {
      await _service.signUp(email, password).then((User user) {
        // TODO: implement
        state = state.copyWith(
            signUpStatus: AuthRequestStatus.success,
            authStatus: AuthStatus.authenticated);
      });
    } catch (e) {
      state = state.copyWith(signUpStatus: AuthRequestStatus.failed);
      // Error handling to set up
    }
  }
}
