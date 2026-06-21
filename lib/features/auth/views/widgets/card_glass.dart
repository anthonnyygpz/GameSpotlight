import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardGlass extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Color? borderColor;
  final Color focusedBorderColor;
  final double? borderSize;
  final ImageProvider<Object>? bgImage;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? bgColor;
  final bool enableBlur;
  final bool isEntry;
  final bool autofocus;
  final double borderRadius;

  const CardGlass({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(0),
    this.color,
    this.borderColor,
    this.focusedBorderColor = Colors.white,
    this.bgImage,
    this.borderSize,
    this.onPressed,
    this.width,
    this.height,
    this.bgColor,
    this.enableBlur = true,
    this.isEntry = false,
    this.autofocus = false,
    this.borderRadius = 10,
  });

  @override
  State<CardGlass> createState() => _CardGlassState();
}

class _CardGlassState extends State<CardGlass> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final bool isInteractive = widget.onPressed != null;

    // Contenedor principal con efecto Glassmorphism y animación de estado
    Widget container = AnimatedContainer(
      width: widget.width,
      height: widget.height,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: widget.color ?? Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        image: widget.bgImage != null
            ? DecorationImage(
                image: widget.bgImage!,
                fit: BoxFit.cover,
                colorFilter: _isFocused
                    ? null
                    : ColorFilter.mode(Colors.grey, BlendMode.color),
              )
            : null,
        border: Border.all(
          color: _isFocused
              ? widget.focusedBorderColor
              : (widget.borderColor ?? Colors.grey.shade500),
          width: _isFocused
              ? (widget.borderSize ?? 2) + 4
              : (widget.borderSize ?? 2),
        ),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: widget.focusedBorderColor.withValues(alpha: 0.5),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ]
            : [],
      ),
      child: Padding(padding: widget.padding, child: widget.child),
    );

    Widget content = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: widget.enableBlur
          ? BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: container,
            )
          : container,
    );

    // Si no hay onPressed, se renderiza solo la tarjeta sin interactividad
    if (!isInteractive) {
      return content;
    }

    return Focus(
      autofocus: widget.autofocus,
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            (event.logicalKey == LogicalKeyboardKey.select ||
                event.logicalKey == LogicalKeyboardKey.enter ||
                event.logicalKey == LogicalKeyboardKey.gameButtonA)) {
          widget.onPressed?.call();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: GestureDetector(onTap: widget.onPressed, child: content),
    );
  }
}
