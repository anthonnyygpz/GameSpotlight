import 'package:flutter/material.dart';

class LineOpacity extends StatelessWidget {
  final bool flipX;
  final double? width;
  final double? height;
  const LineOpacity({
    super.key,
    this.flipX = false,
    this.width = 15.0,
    this.height = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: flipX,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: .centerLeft,
            end: .centerRight,
            colors: [Colors.white, Colors.white.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}
