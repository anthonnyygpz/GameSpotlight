import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/domain/auth/usecases/auth/login_usecase.dart';
import 'package:game_tv/core/providers/auth/auth_provider.dart';
import 'package:game_tv/core/utils/validators.dart';
import 'package:game_tv/core/widgets/tv_button.dart';
import 'package:game_tv/core/widgets/tv_text_field.dart';
import 'package:game_tv/features/auth/views/widgets/more_form_login.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.onSwitch});

  final VoidCallback onSwitch;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  static const _paddingHorizontal = 30.0;
  static const _spacing = 15.0;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: _FormContent(cs: cs, onSwitch: widget.onSwitch),
        ),
        _VerticalDivider(cs: cs),
        const Expanded(child: MoreFormLogin()),
      ],
    );
  }
}

class _FormContent extends ConsumerStatefulWidget {
  const _FormContent({required this.cs, required this.onSwitch});

  final ColorScheme cs;
  final VoidCallback onSwitch;

  @override
  ConsumerState<_FormContent> createState() => _FormContentState();
}

class _FormContentState extends ConsumerState<_FormContent> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController(
    text: 'anthony@gmail.com',
  );
  final _passwordController = TextEditingController(text: 'Antony1511@');

  TvTextFieldStyle get _fieldStyle => TvTextFieldStyle(
    focusBackgroundColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    labelColor: Colors.white,
    labelFocusColor: widget.cs.secondary,
    valueColor: Colors.white,
    hintColor: Colors.grey,
  );

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(loginProvider, (_, state) {
      state.whenOrNull(
        error: (error, _) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: widget.cs.error,
          ),
        ),
      );
    });

    final isLoading = ref.watch(loginProvider).isLoading;

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: _LoginFormState._paddingHorizontal,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: _LoginFormState._spacing,
          children: [
            _buildTitle(),
            _buildEmailField(isLoading),
            _buildPasswordField(isLoading),
            _buildSubmitButton(isLoading),
            _buildForgotPasswordButton(),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  Widget _buildTitle() {
    return const Text(
      'ACCESO A TU CUENTA',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 34,
      ),
    );
  }

  Widget _buildEmailField(bool isLoading) {
    return TvTextField(
      isLoading: isLoading,
      controller: _identifierController,
      label: 'CORREO ELECTRÓNICO',
      prefixIcon: const Icon(Icons.email, color: Colors.grey),
      autofocus: true,
      style: _fieldStyle,
      validator: Validators.compose([
        Validators.required(label: 'Correo electrónico'),
        Validators.email(),
      ]),
    );
  }

  Widget _buildPasswordField(bool isLoading) {
    return TvTextField(
      isLoading: isLoading,
      controller: _passwordController,
      label: 'CONTRASEÑA',
      prefixIcon: const Icon(Icons.lock_sharp, color: Colors.grey),
      obscureText: true,
      style: _fieldStyle,
      validator: Validators.compose([
        Validators.required(label: 'Contraseña'),
        Validators.strongPassword(),
        Validators.minLength(
          8,
          message: 'La contraseña debe tener mín. 8 caracteres.',
        ),
      ]),
    );
  }

  Widget _buildSubmitButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      child: TvButton(
        isLoading: isLoading,
        label: 'ENTRAR',
        icon: Icons.login,
        onPressed: _validateAndSubmit,
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return TvButton.ghost(label: '¿Olvidaste tu contraseña?', onPressed: () {});
  }

  Widget _buildRegisterButton() {
    return TvButton.ghost(
      label: 'CREAR NUEVA CUENTA',
      colorText: widget.cs.primary,
      onPressed: widget.onSwitch,
    );
  }

  void _validateAndSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final entity = LoginParams(
      identifier: _identifierController.text,
      password: _passwordController.text,
    );

    ref.read(loginProvider.notifier).call(entity);
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider({required this.cs});

  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: VerticalDivider(color: cs.primary, width: 1, thickness: 1),
    );
  }
}
