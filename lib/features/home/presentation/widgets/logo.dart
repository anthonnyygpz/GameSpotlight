import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Image.asset('assets/logo.png', width: 30),
        Text(
          'GAME\nSPOTLIGHT',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Microgramma',
          ),
        ),
      ],
    );
  }
}
