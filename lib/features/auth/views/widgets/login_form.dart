import 'package:flutter/material.dart';
import 'package:game_tv/core/constants/app_routes.dart';
import 'package:game_tv/core/widgets/icon_text_button.dart';
import 'package:game_tv/core/widgets/tv_text_field.dart';
import 'package:game_tv/features/auth/views/widgets/more_form_login.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onSwitch;
  const LoginForm({super.key, required this.onSwitch});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  void onSubmit() {
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 15,
              children: [
                Text(
                  'ACCESO A TU CUENTA',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 34,
                  ),
                ),

                TvTextField(
                  label: 'CORREO ELECTRONICO / USUARIO',
                  prefixIcon: const Icon(Icons.email, color: Colors.grey),
                  style: TvTextFieldStyle(
                    focusBackgroundColor: Colors.transparent,
                    labelFocusColor: Colors.deepPurple.shade200,
                    hintColor: Colors.grey,
                    backgroundColor: Colors.transparent,
                    labelColor: Colors.white,
                    valueColor: Colors.white,
                  ),
                ),

                TvTextField(
                  label: 'CONTRASEÑA',
                  prefixIcon: const Icon(Icons.email, color: Colors.grey),
                  style: TvTextFieldStyle(
                    focusBackgroundColor: Colors.transparent,
                    hintColor: Colors.grey,
                    labelFocusColor: Colors.deepPurple.shade200,
                    backgroundColor: Colors.transparent,
                    labelColor: Colors.white,
                    valueColor: Colors.white,
                  ),
                ),

                // CustomTextFormField(
                //   label: 'CORREO ELECTRONICO / USUARIO',
                //   prefixIcon: const Icon(Icons.email, color: Colors.grey),
                // ),

                // CustomTextFormField(
                //   label: 'CONTRASEÑA',
                //   isPassword: true,
                //   prefixIcon: const Icon(Icons.lock_sharp, color: Colors.grey),
                // ),
                SizedBox(
                  width: double.infinity,
                  child: IconTextButton(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    backgroundColor: Colors.deepPurple,
                    focusedColor: Colors.deepPurple.shade200,
                    text: Text('ENTRAR', style: TextStyle(color: Colors.white)),
                    icon: Icon(Icons.person, color: Colors.white),
                    onPressed: onSubmit,
                  ),
                ),

                IconTextButton(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  backgroundColor: Colors.transparent,
                  focusedColor: Colors.deepPurple.shade200.withValues(
                    alpha: 0.5,
                  ),
                  text: Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  onPressed: () {},
                ),

                IconTextButton(
                  text: Text(
                    'CREAR NUEVA CUENTA',
                    style: TextStyle(fontSize: 18),
                  ),
                  backgroundColor: Colors.transparent,
                  focusedColor: Colors.deepPurple.shade200.withValues(
                    alpha: 0.1,
                  ),
                  onPressed: widget.onSwitch,
                ),
              ],
            ),
          ),
        ),

        // Divider
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 1,
            height: double.infinity,
            color: Colors.deepPurple,
          ),
        ),

        // More form login
        Expanded(child: MoreFormLogin()),
      ],
    );
  }
}
