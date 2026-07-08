import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum DPadAction { up, down, left, right, select, back }

class DPadListener extends StatefulWidget {
  const DPadListener({
    super.key,
    required this.child,
    required this.onAction,
    this.autofocus = false,
    this.focusNode,
  });

  final Widget child;
  final KeyEventResult Function(DPadAction action) onAction;
  final bool autofocus;
  final FocusNode? focusNode;

  @override
  State<DPadListener> createState() => _DPadListenerState();
}

class _DPadListenerState extends State<DPadListener> {
  FocusNode? _intervalNode;
  FocusNode get _node => widget.focusNode ?? (_intervalNode ??= FocusNode());

  @override
  void dispose() {
    _intervalNode?.dispose();
    super.dispose();
  }

  DPadAction? _mapKey(LogicalKeyboardKey key) {
    if (key == LogicalKeyboardKey.arrowUp) return DPadAction.up;
    if (key == LogicalKeyboardKey.arrowDown) return DPadAction.down;
    if (key == LogicalKeyboardKey.arrowLeft) return DPadAction.left;
    if (key == LogicalKeyboardKey.arrowRight) return DPadAction.right;
    if (key == LogicalKeyboardKey.select || key == LogicalKeyboardKey.enter) {
      return DPadAction.select;
    }
    if (key == LogicalKeyboardKey.goBack || key == LogicalKeyboardKey.escape) {
      return DPadAction.back;
    }
    return null;
  }

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final action = _mapKey(event.logicalKey);
    if (action == null) return KeyEventResult.ignored;
    return widget.onAction(action);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _node,
      autofocus: widget.autofocus,
      onKeyEvent: _onKeyEvent,
      child: widget.child,
    );
  }
}
