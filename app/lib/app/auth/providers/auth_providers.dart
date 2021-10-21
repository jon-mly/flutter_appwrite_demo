import 'package:appwrite_demo/app/auth/data/auth_state.dart';
import 'package:appwrite_demo/app/auth/notifier/auth_notifier.dart';
import 'package:appwrite_demo/services/auth/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Service Provider
final _authServiceProvider =
    Provider.autoDispose<IAuthService>((ref) => AuthService(ref.read));

// StateNotifier
final authStateProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, AuthState>(
        (ref) => AuthNotifier(service: ref.watch(_authServiceProvider)));

// User Id Provider
final userIdProvider = Provider.autoDispose<String?>(
    (ref) => ref.watch(authStateProvider.select((state) => state.userId)));
