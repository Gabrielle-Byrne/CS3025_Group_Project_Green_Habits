import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/auth_store.dart';

class RequireAuth extends StatelessWidget {
  final Widget child;
  const RequireAuth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthStore>();

    if (auth.isLoggedIn) return child;

    // If not logged in, show login screen instead of the protected page.
    // (This avoids users accessing pages directly via routes.)
    return const _GoToLogin();
  }
}

class _GoToLogin extends StatelessWidget {
  const _GoToLogin();

  @override
  Widget build(BuildContext context) {
    // Defer navigation to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
    });
    return const SizedBox.shrink();
  }
}