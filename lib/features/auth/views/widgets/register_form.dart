import 'package:flutter/material.dart';
import 'package:game_tv/core/widgets/icon_text_button.dart';
import 'package:game_tv/core/widgets/tv_text_field.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback onSwitch;
  const RegisterForm({super.key, required this.onSwitch});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
                  'REGISTRAR UNA NUEVA CUENTA',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 34,
                  ),
                ),

                TvTextField(
                  label: 'CORREO ELECTRONICO / USUARIO',
                  prefixIcon: const Icon(Icons.email, color: Colors.grey),
                ),
                // CustomTextFormField(
                //   label: 'CORREO ELECTRONICO / USUARIO',
                //   prefixIcon: const Icon(Icons.email, color: Colors.grey),
                // ),
                //
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
                    text: Text(
                      'REGISTRAR',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(Icons.person, color: Colors.white),
                    onPressed: widget.onSwitch,
                  ),
                ),

                IconTextButton(
                  text: Text(
                    'YA TIENES CUENTA',
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
      ],
    );
  }
}
