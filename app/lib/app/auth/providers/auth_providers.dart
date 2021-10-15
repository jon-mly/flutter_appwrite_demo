import 'package:appwrite_demo/app/auth/auth_state.dart';
import 'package:appwrite_demo/app/auth/notifier/auth_notifier.dart';
import 'package:appwrite_demo/services/auth/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier
final authStateProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, AuthState>(
        (ref) => AuthNotifier(service: ref.watch(_authServiceProvider)));

// Service Provider
final _authServiceProvider =
    Provider.autoDispose<IAuthService>((ref) => AuthService());
