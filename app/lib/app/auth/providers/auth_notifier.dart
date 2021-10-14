import 'package:appwrite_demo/app/auth/auth_state.dart';
import 'package:appwrite_demo/services/auth/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({required IAuthService service})
      : _service = service,
        super(AuthState.initial());

  IAuthService _service;

  //
  // Auth
  //

  Future<void> login(String email, String password) async {
    try {
      bool loggedIn = await _service.login(email, password);
    } catch (e) {
      // todo: error handling
    }
  }

  Future<void> signUp(String email, String password) async {}
}
