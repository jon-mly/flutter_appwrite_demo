import 'package:appwrite_demo/app/auth/data/auth_state.dart';
import 'package:appwrite_demo/app/auth/providers/auth_providers.dart';
import 'package:appwrite_demo/app/tasks/tasks_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //
  // ########## Lifecycle
  //

  @override
  void initState() {
    super.initState();

    // Doesn't work. Might be related to SharedPreferences not being ready at
    // the time this is fired given the quick start scenario.
    _getActiveSession();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  //
  // ########## Events
  //

  Future<void> _getActiveSession() async {
    await ref.read(authStateProvider.notifier).getActiveSession();

    final AuthStatus status = ref.read(authStateProvider).authStatus;
    if (status == AuthStatus.authenticated) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const TaskListPage()));
    }
  }

  Future<void> _signUp() async {
    final String email = _emailController.text;
    final String password = _emailController.text;

    await ref.read(authStateProvider.notifier).signUp(email, password);

    final AuthStatus status = ref.read(authStateProvider).authStatus;
    if (status == AuthStatus.authenticated) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const TaskListPage()));
    }
  }

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _emailController.text;

    await ref.read(authStateProvider.notifier).login(email, password);

    final AuthStatus status = ref.read(authStateProvider).authStatus;
    if (status == AuthStatus.authenticated) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const TaskListPage()));
    }
  }

  //
  // ########## UI
  //

  Widget _buildBody() {
    final AuthRequestStatus loginStatus =
        ref.watch(authStateProvider).loginStatus;
    final AuthRequestStatus signUpStatus =
        ref.watch(authStateProvider).signUpStatus;
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: "Email Address"),
            ),
            TextField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(hintText: "Password"),
            ),
            ElevatedButton(
                onPressed: _getActiveSession,
                child: (loginStatus == AuthRequestStatus.loading)
                    ? const CircularProgressIndicator()
                    : const Text("Get Active Session")),
            ElevatedButton(
                onPressed: _login,
                child: (loginStatus == AuthRequestStatus.loading)
                    ? const CircularProgressIndicator()
                    : const Text("Log In")),
            ElevatedButton(
                onPressed: _signUp,
                child: (signUpStatus == AuthRequestStatus.loading)
                    ? const CircularProgressIndicator()
                    : const Text("Sign Up")),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AppWrite + Riverpod Demo"),
      ),
      body: _buildBody(),
    );
  }
}
