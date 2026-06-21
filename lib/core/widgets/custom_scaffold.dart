import 'package:dpad/dpad.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatefulWidget {
  final Widget child;
  const CustomScaffold({super.key, required this.child});

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return DpadRegion(
      child: Scaffold(
        backgroundColor: const Color(0xFF050812),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [widget.child],
          ),
        ),
      ),
    );
  }
}
