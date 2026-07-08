import 'package:flutter/material.dart';
import 'package:gamespotlight/features/auth/views/widgets/login_form.dart';
import 'package:gamespotlight/features/auth/views/widgets/register_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isRegister = false;

  void _swichToLogin() => setState(() => _isRegister = false);
  void _swichToRegister() => setState(() => _isRegister = true);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: _Background(
        child: Padding(
          padding: const .all(20.0),
          child: _AuthCard(
            cs: cs,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: _slideTransition,
              child: _isRegister
                  ? RegisterForm(
                      key: const ValueKey('Register'),
                      onSwitch: _swichToLogin,
                    )
                  : LoginForm(
                      key: const ValueKey('Login'),
                      onSwitch: _swichToRegister,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _slideTransition(Widget child, Animation<double> animation) {
    final isEntering =
        (child.key == const ValueKey('Register') && _isRegister) ||
        (child.key == const ValueKey('Login') && !_isRegister);

    final offset = Tween<Offset>(
      begin: isEntering ? const Offset(1.2, 0) : const Offset(-1.2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic));

    return SlideTransition(position: offset, child: child);
  }
}

class _Background extends StatelessWidget {
  const _Background({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/portada.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: SizedBox.expand(child: child),
    );
  }
}

class _AuthCard extends StatelessWidget {
  const _AuthCard({required this.child, required this.cs});

  final Widget child;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: .circular(20),
        border: .all(color: cs.primary, width: 2),
      ),
      child: child,
    );
  }
}
