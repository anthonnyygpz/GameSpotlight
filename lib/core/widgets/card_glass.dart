import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardGlass extends StatefulWidget {
  const CardGlass({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.color,
    this.borderColor,
    this.focusedBorderColor = Colors.white,
    this.bgImage,
    this.borderSize,
    this.onPressed,
    this.width,
    this.height,
    this.isEntry = false,
    this.autofocus = false,
    this.borderRadius = 10,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Color? borderColor;
  final Color focusedBorderColor;
  final ImageProvider<Object>? bgImage;
  final double? borderSize;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final bool isEntry;
  final bool autofocus;
  final double borderRadius;

  @override
  State<CardGlass> createState() => _CardGlassState();
}

class _CardGlassState extends State<CardGlass> {
  static const _animDuration = Duration(milliseconds: 200);
  static const _focusBorderExtra = 4.0;
  static const _shadowBlur = 15.0;
  static const _shadowSpread = 1.0;

  static final _acceptedKeys = {
    LogicalKeyboardKey.select,
    LogicalKeyboardKey.enter,
    LogicalKeyboardKey.gameButtonA,
  };

  bool _isFocused = false;

  bool get _isInteractive => widget.onPressed != null;

  void _onFocusChange(bool hasFocus) => setState(() => _isFocused = hasFocus);

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent && _acceptedKeys.contains(event.logicalKey)) {
      widget.onPressed?.call();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final content = ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: AnimatedContainer(
        width: widget.width,
        height: widget.height,
        duration: _animDuration,
        curve: Curves.easeInOut,
        decoration: _buildDecoration(),
        child: Padding(padding: widget.padding, child: widget.child),
      ),
    );

    if (!_isInteractive) return content;

    return Focus(
      autofocus: widget.autofocus,
      onFocusChange: _onFocusChange,
      onKeyEvent: _onKeyEvent,
      child: GestureDetector(onTap: widget.onPressed, child: content),
    );
  }

  BoxDecoration _buildDecoration() {
    final baseBorderSize = widget.borderSize ?? 2;

    return BoxDecoration(
      color: widget.color ?? Colors.transparent,
      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
      image: _buildImageDecoration(),
      border: Border.all(
        color: _isFocused
            ? widget.focusedBorderColor
            : (widget.borderColor ?? Colors.grey.shade500),
        width: _isFocused ? baseBorderSize + _focusBorderExtra : baseBorderSize,
      ),
      boxShadow: _isFocused
          ? [
              BoxShadow(
                color: widget.focusedBorderColor.withValues(alpha: 0.5),
                blurRadius: _shadowBlur,
                spreadRadius: _shadowSpread,
              ),
            ]
          : [],
    );
  }

  DecorationImage? _buildImageDecoration() {
    if (widget.bgImage == null) return null;

    return DecorationImage(
      image: widget.bgImage!,
      fit: BoxFit.cover,
      colorFilter: _isFocused
          ? null
          : const ColorFilter.mode(Colors.grey, BlendMode.color),
    );
  }
}
