abstract class IAuthService {
  Future<bool> login(String email, String password);

  Future<bool> signUp(String email, String password);
}

class AuthService implements IAuthService {
  //
  // Services
  //

  @override
  Future<bool> login(String email, String password) {
    return Future.delayed(const Duration(seconds: 2)).then((value) => true);
  }

  @override
  Future<bool> signUp(String email, String password) {
    return Future.delayed(const Duration(seconds: 2)).then((value) => true);
  }
}
