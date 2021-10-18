import 'package:appwrite/models.dart';
import 'package:appwrite_demo/app/general_providers/shared_preferences_provider.dart';
import 'package:appwrite_demo/services/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class IAuthService {
  Future<Session?> getActiveSession();
  Future<User> signUp(String email, String password);
  Future<Session> createAccountSession(String email, String password);
}

class AuthService implements IAuthService {
  final Reader _read;

  AuthService(this._read);

  @override
  Future<Session?> getActiveSession() async {
    final String? sessionId =
        _read(sharedPrefsDataProvider)?.activeAccountSessionId;
    if (sessionId == null) return null;
    return await _read(appwriteAccountProvider)
        .getSession(sessionId: sessionId);
  }

  @override
  Future<Session> createAccountSession(String email, String password) async {
    return await _read(appwriteAccountProvider)
        .createSession(email: email, password: password);
  }

  @override
  Future<User> signUp(String email, String password) {
    return _read(appwriteAccountProvider)
        .create(email: email, password: password);
  }
}
