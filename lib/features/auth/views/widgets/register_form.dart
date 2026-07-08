import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/domain/auth/usecases/auth/register_usecase.dart';
import 'package:gamespotlight/core/providers/auth/auth_provider.dart';
import 'package:gamespotlight/core/utils/validators.dart';
import 'package:gamespotlight/core/widgets/tv_button.dart';
import 'package:gamespotlight/core/widgets/tv_text_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key, required this.onSwitch});

  final VoidCallback onSwitch;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: _FormContent(cs: cs, onSwitch: onSwitch),
        ),
      ],
    );
  }
}

class _FormContent extends ConsumerStatefulWidget {
  const _FormContent({required this.cs, required this.onSwitch});

  final ColorScheme cs;
  final VoidCallback onSwitch;

  static const _kPaddingHorizontal = 30.0;
  static const _kSpacing = 15.0;

  @override
  ConsumerState<_FormContent> createState() => _FormContentState();
}

class _FormContentState extends ConsumerState<_FormContent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Antonio');
  final _emailController = TextEditingController(text: 'anthony@gmail.com');
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
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(registerProvider, (_, state) {
      state.whenOrNull(
        error: (error, _) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: widget.cs.error,
          ),
        ),
        // data: (_) => context.go('/home'), // Navega aquí cuando tengas router
      );
    });

    final isLoading = ref.watch(registerProvider).isLoading;

    return Form(
      key: _formKey,
      child: Padding(
        padding: const .symmetric(horizontal: _FormContent._kPaddingHorizontal),
        child: Column(
          mainAxisAlignment: .center,
          spacing: _FormContent._kSpacing,
          children: [
            _buildTitle(),
            _buildNameField(isLoading),
            _buildEmailField(isLoading),
            _buildPasswordField(isLoading),
            _buildSubmitButton(isLoading),
            _buildLoginButton(isLoading),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'REGISTRAR UNA NUEVA CUENTA',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 34,
      ),
    );
  }

  Widget _buildNameField(bool isLoading) {
    return TvTextField(
      isLoading: isLoading,
      controller: _nameController,
      label: 'NOMBRE / USUARIO',
      prefixIcon: const Icon(Icons.person, color: Colors.grey),
      autofocus: true,
      style: _fieldStyle,
      validator: Validators.compose([
        Validators.required(label: 'Nombre / Usuario'),
        Validators.minLength(3, message: 'El nombre / usuario es muy corto.'),
      ]),
    );
  }

  Widget _buildEmailField(bool isLoading) {
    return TvTextField(
      isLoading: isLoading,
      controller: _emailController,
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
        label: 'REGISTRAR',
        icon: Icons.person,
        onPressed: _validateAndSubmit,
      ),
    );
  }

  Widget _buildLoginButton(bool isLoading) {
    return TvButton.ghost(
      isLoading: isLoading,
      label: 'YA TIENES CUENTA',
      onPressed: widget.onSwitch,
    );
  }

  void _validateAndSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final entity = RegisterParams(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      country: 'MX',
    );

    ref.read(registerProvider.notifier).call(entity);
  }
}
