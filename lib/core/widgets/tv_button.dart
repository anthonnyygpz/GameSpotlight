import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamespotlight/core/widgets/loading_expressive.dart';

class TvButton extends StatefulWidget {
  const TvButton({
    super.key,
    this.label,
    this.icon,
    this.iconSize = 24,
    this.textSize = 14.0,
    this.width,
    this.height,
    this.padding,
    this.autofocus = false,
    this.variant = TvButtonVariant.filled,
    this.colorText = Colors.white,
    this.colorIcon = Colors.white,
    required this.onPressed,
    this.isLoading = false,
    this.isFocusedOverride,
  }) : assert(
         label != null || icon != null,
         'TvButton requiere al menos label o icon',
       );

  const TvButton.ghost({
    super.key,
    this.label,
    this.icon,
    this.iconSize = 24,
    this.textSize = 14.0,
    this.width,
    this.height,
    this.padding,
    this.autofocus = false,
    this.colorText = Colors.white,
    this.colorIcon = Colors.white,
    required this.onPressed,
    this.isLoading = false,
    this.isFocusedOverride,
  }) : variant = TvButtonVariant.ghost;

  const TvButton.outlined({
    super.key,
    this.label,
    this.icon,
    this.iconSize = 24,
    this.textSize = 14.0,
    this.width,
    this.height,
    this.padding,
    this.autofocus = false,
    this.colorText = Colors.white,
    this.colorIcon = Colors.white,
    required this.onPressed,
    this.isLoading = false,
    this.isFocusedOverride,
  }) : variant = TvButtonVariant.outlined;

  final String? label;
  final IconData? icon;
  final double iconSize;
  final double textSize;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool autofocus;
  final TvButtonVariant variant;
  final Color colorText;
  final Color colorIcon;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool? isFocusedOverride;

  @override
  State<TvButton> createState() => _TvButtonState();
}

enum TvButtonVariant { filled, outlined, ghost }

class _TvButtonState extends State<TvButton> {
  static const _borderRadius = 10.0;
  static const _borderWidth = 2.0;
  static const _animDuration = Duration(milliseconds: 200);
  static const _defaultPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );
  static final _acceptedKeys = {
    LogicalKeyboardKey.select,
    LogicalKeyboardKey.enter,
    LogicalKeyboardKey.gameButtonA,
  };

  bool _internalFocused = false;
  bool get _isFocused => widget.isFocusedOverride ?? _internalFocused;

  void _onFocusChange(bool hasFocus) =>
      setState(() => _internalFocused = hasFocus);

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent && _acceptedKeys.contains(event.logicalKey)) {
      if (widget.isLoading) return KeyEventResult.handled;
      widget.onPressed();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Focus(
      autofocus: widget.autofocus,
      onFocusChange: _onFocusChange,
      onKeyEvent: _onKeyEvent,
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onPressed,
        child: AnimatedScale(
          scale: _isFocused ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: AnimatedContainer(
            duration: _animDuration,
            width: widget.width,
            height: widget.height,
            padding: widget.padding ?? _defaultPadding,
            decoration: _buildDecoration(cs),
            child: _ButtonContent(
              label: widget.label,
              icon: widget.icon,
              iconSize: widget.iconSize,
              textSize: widget.textSize,
              colorText: widget.colorText,
              isLoading: widget.isLoading,
              colorIcon: widget.colorIcon,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(ColorScheme cs) {
    final colorFilled = _isFocused
        ? cs.primary
        : cs.surface.withValues(alpha: 0.5);
    final colorOutlined = _isFocused
        ? cs.primary.withValues(alpha: 0.1)
        : Colors.transparent;
    final colorGhost = _isFocused
        ? cs.primary
        : cs.surface.withValues(alpha: 0.4);

    return switch (widget.variant) {
      TvButtonVariant.filled => BoxDecoration(
        color: colorFilled,
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(
          color: _isFocused ? Colors.white : cs.primary,
          width: _borderWidth,
        ),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: cs.primary.withValues(alpha: 0.5),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
      TvButtonVariant.outlined => BoxDecoration(
        color: colorOutlined,
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(
          color: _isFocused ? cs.primary : cs.outline,
          width: _borderWidth,
        ),
      ),
      TvButtonVariant.ghost => BoxDecoration(
        color: colorGhost,
        borderRadius: .circular(_borderRadius),
      ),
    };
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.icon,
    required this.iconSize,
    required this.textSize,
    required this.colorText,
    required this.colorIcon,
    required this.isLoading,
  });

  final String? label;
  final IconData? icon;
  final double iconSize;
  final double textSize;
  final Color colorText;
  final Color colorIcon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: textSize + 4,
          height: textSize + 4,
          child: LoadingExpressive(strokeWidth: 2.5, color: colorText),
        ),
      );
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          if (icon != null) ...[Icon(icon, color: colorIcon, size: iconSize)],
          if (label != null)
            Text(
              label!,
              style: TextStyle(
                color: colorText,
                fontSize: textSize,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
        ],
      ),
    );
  }
}
