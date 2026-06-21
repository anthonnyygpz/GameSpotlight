import 'dart:ui';

import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final bool isPassword;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? label;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.keyboardType,
    this.label,
  }) : assert(
         !(isPassword && suffixIcon != null),
         'Protocolo de error: No puede asignar un suffixIcon personalizado si isPassword está activado.',
       );

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),

        if (widget.label != null) const SizedBox(height: 5),

        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(
                  alpha: 0.1,
                ), // Tinte azul semi-transparente
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                controller: widget.controller,
                validator: widget.validator,
                keyboardType: widget.keyboardType,
                obscureText: obscureText,
                style: TextStyle(color: color.onPrimary),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(),
                  ),
                  hintText: widget.hintText,
                  labelText: widget.labelText,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.isPassword
                      ? IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        )
                      : widget.suffixIcon,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: color.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: color.error),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: color.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: color.primary),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
