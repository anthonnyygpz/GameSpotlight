import 'package:flutter/material.dart';
import 'package:material3_expressive_loading_indicator/material3_expressive_loading_indicator.dart';

class LoadingExpressive extends StatelessWidget {
  const LoadingExpressive({super.key, this.strokeWidth, this.color});
  final double? strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) => Center(
    child: ExpressiveLoadingIndicator(
      strokeWidth: strokeWidth,
      color: color,
      style: .outlined,
    ),
  );
}
