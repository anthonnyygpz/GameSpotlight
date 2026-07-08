import 'package:flutter/widgets.dart';

class RowScrollControllers {
  RowScrollControllers(int count)
    : _controllers = List.generate(count, (_) => ScrollController());

  final List<ScrollController> _controllers;

  List<ScrollController> get all => _controllers;

  ScrollController forRow(int rowIndex) => _controllers[rowIndex];

  void disposeAll() {
    for (final c in _controllers) {
      c.dispose();
    }
  }
}
