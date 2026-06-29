import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/widgets/loading_expressive.dart';

class AsyncUIBuilder<T> extends StatelessWidget {
  const AsyncUIBuilder({
    super.key,
    required this.asyncValue,
    required this.builder,
    this.onError,
    this.onLoading,
  });

  final AsyncValue<T> asyncValue;
  final Widget Function(T data) builder;
  final Widget Function(Object error)? onError;
  final Widget? onLoading;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return switch (asyncValue) {
      AsyncData(:final value) => _buildData(value),
      AsyncError(:final error) =>
        onError?.call(error) ?? _buildError(cs, error),
      _ => onLoading ?? _buildLoading(),
    };
  }

  Widget _buildData(T value) {
    return Scaffold(body: builder(value));
  }

  Widget _buildError(ColorScheme cs, Object error) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber_rounded, color: cs.error, size: 48),
            const SizedBox(height: 16),
            Text(
              'Anomalía detectada:\n$error',
              textAlign: .center,
              style: TextStyle(color: cs.error),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Scaffold(body: LoadingExpressive());
  }
}
