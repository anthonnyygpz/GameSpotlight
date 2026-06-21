import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================================
// TvTextFieldStyle — sistema de colores y estilos del widget
// ============================================================================

/// Controla todos los colores y estilos visuales de [TvTextField].
///
/// Cada propiedad acepta `null`, lo que hace que el widget use el color
/// por defecto del [ThemeData] activo. Así puedes sobreescribir solo lo
/// que necesitas sin tener que rellenar todo.
///
/// Ejemplo mínimo — solo cambiar el color de foco:
/// ```dart
/// TvTextField(
///   label: 'Usuario',
///   style: TvTextFieldStyle(focusColor: Colors.amber),
/// )
/// ```
///
/// Ejemplo completo — tema personalizado tipo NieR:
/// ```dart
/// TvTextField(
///   label: 'Usuario',
///   style: TvTextFieldStyle(
///     focusColor: const Color(0xFFCBAF72),       // dorado NieR
///     borderColor: const Color(0xFF4A4A4A),
///     backgroundColor: const Color(0xFF1A1A1A),
///     focusBackgroundColor: const Color(0xFF2A2318),
///     labelColor: const Color(0xFF8A8A8A),
///     valueColor: const Color(0xFFE8E0CC),
///     hintColor: const Color(0xFF5A5A5A),
///     iconColor: const Color(0xFF6A6A6A),
///     dialogBackgroundColor: const Color(0xFF1E1E1E),
///     confirmButtonColor: const Color(0xFFCBAF72),
///     confirmButtonTextColor: const Color(0xFF0D0D0D),
///   ),
/// )
/// ```
class TvTextFieldStyle {
  const TvTextFieldStyle({
    // -- Campo visual (foco activo) --
    this.focusColor,
    this.focusBackgroundColor,
    this.focusBorderWidth = 2.5,
    this.focusGlowRadius = 12.0,
    this.focusGlowOpacity = 0.25,

    // -- Campo visual (sin foco) --
    this.borderColor,
    this.borderWidth = 1.5,
    this.backgroundColor,
    this.borderRadius = 8.0,

    // -- Textos del campo visual --
    this.labelColor,
    this.labelFocusColor,
    this.valueColor,
    this.hintColor,

    // -- Ícono de edición y prefixIcon --
    this.iconColor,
    this.iconFocusColor,

    // -- Diálogo --
    this.dialogBackgroundColor,
    this.dialogBorderRadius = 16.0,
    this.dialogHeaderIconColor,
    this.dialogTitleColor,
    this.dialogFieldBorderColor,
    this.dialogFieldFocusBorderColor,
    this.dialogFieldTextColor,
    this.dialogFieldHintColor,

    // -- Botón Confirmar --
    this.confirmButtonColor,
    this.confirmButtonTextColor,

    // -- Botón Cancelar --
    this.cancelButtonBorderColor,
    this.cancelButtonTextColor,
    this.cancelButtonFocusBorderColor,
  });

  // Foco activo
  final Color? focusColor;
  final Color? focusBackgroundColor;
  final double focusBorderWidth;
  final double focusGlowRadius;
  final double focusGlowOpacity;

  // Sin foco
  final Color? borderColor;
  final double borderWidth;
  final Color? backgroundColor;
  final double borderRadius;

  // Textos
  final Color? labelColor;
  final Color? labelFocusColor;
  final Color? valueColor;
  final Color? hintColor;

  // Íconos
  final Color? iconColor;
  final Color? iconFocusColor;

  // Diálogo
  final Color? dialogBackgroundColor;
  final double dialogBorderRadius;
  final Color? dialogHeaderIconColor;
  final Color? dialogTitleColor;
  final Color? dialogFieldBorderColor;
  final Color? dialogFieldFocusBorderColor;
  final Color? dialogFieldTextColor;
  final Color? dialogFieldHintColor;

  // Botones del diálogo
  final Color? confirmButtonColor;
  final Color? confirmButtonTextColor;
  final Color? cancelButtonBorderColor;
  final Color? cancelButtonTextColor;
  final Color? cancelButtonFocusBorderColor;

  /// Resuelve un color con fallback al [ColorScheme] del tema activo.
  /// Útil internamente para no repetir `?? theme.colorScheme.X` en cada lugar.
  TvTextFieldStyle resolve(ThemeData theme) {
    final cs = theme.colorScheme;
    return TvTextFieldStyle(
      focusColor: focusColor ?? cs.primary,
      focusBackgroundColor:
          focusBackgroundColor ?? cs.primary.withOpacity(0.07),
      focusBorderWidth: focusBorderWidth,
      focusGlowRadius: focusGlowRadius,
      focusGlowOpacity: focusGlowOpacity,
      borderColor: borderColor ?? cs.outline,
      borderWidth: borderWidth,
      backgroundColor: backgroundColor ?? cs.surface,
      borderRadius: borderRadius,
      labelColor: labelColor ?? cs.onSurfaceVariant,
      labelFocusColor: labelFocusColor ?? focusColor ?? cs.primary,
      valueColor: valueColor ?? cs.onSurface,
      hintColor: hintColor ?? cs.onSurfaceVariant.withOpacity(0.6),
      iconColor: iconColor ?? cs.onSurfaceVariant,
      iconFocusColor: iconFocusColor ?? focusColor ?? cs.primary,
      dialogBackgroundColor: dialogBackgroundColor ?? cs.surface,
      dialogBorderRadius: dialogBorderRadius,
      dialogHeaderIconColor: dialogHeaderIconColor ?? focusColor ?? cs.primary,
      dialogTitleColor: dialogTitleColor ?? cs.onSurface,
      dialogFieldBorderColor: dialogFieldBorderColor ?? cs.outline,
      dialogFieldFocusBorderColor:
          dialogFieldFocusBorderColor ?? focusColor ?? cs.primary,
      dialogFieldTextColor: dialogFieldTextColor ?? cs.onSurface,
      dialogFieldHintColor:
          dialogFieldHintColor ?? cs.onSurfaceVariant.withOpacity(0.6),
      confirmButtonColor: confirmButtonColor ?? focusColor ?? cs.primary,
      confirmButtonTextColor: confirmButtonTextColor ?? cs.onPrimary,
      cancelButtonBorderColor: cancelButtonBorderColor ?? cs.outline,
      cancelButtonTextColor: cancelButtonTextColor ?? cs.onSurfaceVariant,
      cancelButtonFocusBorderColor:
          cancelButtonFocusBorderColor ?? focusColor ?? cs.primary,
    );
  }
}

// ============================================================================
// TvTextField — widget principal
// ============================================================================

/// Un TextFormField adaptado para interfaces de TV (10-foot UI / D-pad).
///
/// El campo permanece en modo `readOnly` para evitar que el teclado virtual
/// aparezca al recibir foco por D-pad. Cuando el usuario presiona OK/Select
/// (Enter en el control remoto), se abre un diálogo con el campo real de texto
/// donde puede escribir y confirmar.
///
/// Usa [TvTextFieldStyle] para personalizar colores:
/// ```dart
/// TvTextField(
///   label: 'Nombre de usuario',
///   style: TvTextFieldStyle(
///     focusColor: Colors.amber,
///     backgroundColor: Colors.black,
///   ),
///   onChanged: (value) => print(value),
///   validator: (value) => value!.isEmpty ? 'Requerido' : null,
/// )
/// ```
class TvTextField extends StatefulWidget {
  const TvTextField({
    super.key,
    required this.label,
    this.hint,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.prefixIcon,
    this.maxLength,
    this.autofocus = false,
    this.style,
  });

  final String label;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final int? maxLength;
  final bool autofocus;

  /// Colores y estilos del widget. Si es `null` se usan los del [ThemeData].
  final TvTextFieldStyle? style;

  @override
  State<TvTextField> createState() => _TvTextFieldState();
}

class _TvTextFieldState extends State<TvTextField> {
  late final TextEditingController _displayController;
  late final FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _displayController = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    if (widget.controller == null) {
      _displayController.dispose();
    }
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() => _hasFocus = _focusNode.hasFocus);
  }

  Future<void> _openEditDialog() async {
    // Resolvemos el style aquí para pasarlo al diálogo.
    final resolvedStyle = (widget.style ?? const TvTextFieldStyle()).resolve(
      Theme.of(context),
    );

    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => _TvInputDialog(
        label: widget.label,
        hint: widget.hint,
        initialValue: _displayController.text,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        maxLength: widget.maxLength,
        validator: widget.validator,
        style: resolvedStyle,
      ),
    );

    if (result != null) {
      _displayController.text = result;
      widget.onChanged?.call(result);
      widget.onSubmitted?.call(result);
    }

    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final s = (widget.style ?? const TvTextFieldStyle()).resolve(
      Theme.of(context),
    );

    return KeyboardListener(
      focusNode: FocusNode(skipTraversal: true),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            _focusNode.hasFocus &&
            (event.logicalKey == LogicalKeyboardKey.enter ||
                event.logicalKey == LogicalKeyboardKey.select ||
                event.logicalKey == LogicalKeyboardKey.gameButtonA)) {
          _openEditDialog();
        }
      },
      child: Focus(
        focusNode: _focusNode,
        autofocus: widget.autofocus,
        child: GestureDetector(
          onTap: _openEditDialog,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(s.borderRadius),
              border: Border.all(
                color: _hasFocus ? s.focusColor! : s.borderColor!,
                width: _hasFocus ? s.focusBorderWidth : s.borderWidth,
              ),
              color: _hasFocus ? s.focusBackgroundColor : s.backgroundColor,
              boxShadow: _hasFocus
                  ? [
                      BoxShadow(
                        color: s.focusColor!.withOpacity(s.focusGlowOpacity),
                        blurRadius: s.focusGlowRadius,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                if (widget.prefixIcon != null) ...[
                  IconTheme(
                    data: IconThemeData(
                      color: _hasFocus ? s.iconFocusColor : s.iconColor,
                      size: 22,
                    ),
                    child: widget.prefixIcon!,
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.label,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _hasFocus ? s.labelFocusColor : s.labelColor,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      ValueListenableBuilder(
                        valueListenable: _displayController,
                        builder: (context, value, _) {
                          final hasValue = value.text.isNotEmpty;
                          final displayText = widget.obscureText && hasValue
                              ? '•' * value.text.length
                              : value.text;
                          return Text(
                            hasValue
                                ? displayText
                                : (widget.hint ?? 'Presiona OK para ingresar'),
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: hasValue ? s.valueColor : s.hintColor,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedOpacity(
                  opacity: _hasFocus ? 1.0 : 0.4,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.edit_outlined,
                    size: 18,
                    color: _hasFocus ? s.iconFocusColor : s.iconColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// _TvInputDialog — diálogo con el TextFormField real
// ============================================================================

class _TvInputDialog extends StatefulWidget {
  const _TvInputDialog({
    required this.label,
    required this.initialValue,
    required this.style,
    this.hint,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.validator,
  });

  final String label;
  final String initialValue;
  final TvTextFieldStyle style; // Ya resuelto con los fallbacks del theme
  final String? hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final FormFieldValidator<String>? validator;

  @override
  State<_TvInputDialog> createState() => _TvInputDialogState();
}

class _TvInputDialogState extends State<_TvInputDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;
  bool _obscured = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _obscured = widget.obscureText;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _confirm() {
    if (_formKey.currentState?.validate() ?? true) {
      Navigator.of(context).pop(_controller.text);
    }
  }

  void _cancel() => Navigator.of(context).pop(null);

  @override
  Widget build(BuildContext context) {
    final s = widget.style;
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: s.dialogBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(s.dialogBorderRadius),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Icon(
                      Icons.keyboard_alt_outlined,
                      color: s.dialogHeaderIconColor,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.label,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: s.dialogTitleColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Campo real de texto (aquí SÍ aparece el teclado)
                TextFormField(
                  controller: _controller,
                  autofocus: true,
                  obscureText: _obscured,
                  keyboardType: widget.keyboardType,
                  inputFormatters: widget.inputFormatters,
                  maxLength: widget.maxLength,
                  validator: widget.validator,
                  onFieldSubmitted: (_) => _confirm(),
                  style: textTheme.bodyLarge?.copyWith(
                    color: s.dialogFieldTextColor,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: TextStyle(color: s.dialogFieldHintColor),
                    counterText: '',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: s.dialogFieldBorderColor!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: s.dialogFieldFocusBorderColor!,
                        width: 2,
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    suffixIcon: widget.obscureText
                        ? IconButton(
                            icon: Icon(
                              _obscured
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: s.dialogFieldFocusBorderColor,
                            ),
                            onPressed: () =>
                                setState(() => _obscured = !_obscured),
                          )
                        : null,
                  ),
                ),

                const SizedBox(height: 28),

                // Botones — navegables por D-pad
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _DialogButton(
                      label: 'Cancelar',
                      onPressed: _cancel,
                      outlined: true,
                      borderColor: s.cancelButtonBorderColor!,
                      focusBorderColor: s.cancelButtonFocusBorderColor!,
                      textColor: s.cancelButtonTextColor!,
                    ),
                    const SizedBox(width: 12),
                    _DialogButton(
                      label: 'Confirmar',
                      onPressed: _confirm,
                      backgroundColor: s.confirmButtonColor!,
                      textColor: s.confirmButtonTextColor!,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// _DialogButton — botón D-pad friendly con colores customizables
// ============================================================================

class _DialogButton extends StatefulWidget {
  const _DialogButton({
    required this.label,
    required this.onPressed,
    required this.textColor,
    this.outlined = false,
    // Filled
    this.backgroundColor,
    // Outlined
    this.borderColor,
    this.focusBorderColor,
  });

  final String label;
  final VoidCallback onPressed;
  final bool outlined;
  final Color textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusBorderColor;

  @override
  State<_DialogButton> createState() => _DialogButtonState();
}

class _DialogButtonState extends State<_DialogButton> {
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    final button = widget.outlined
        ? OutlinedButton(
            onPressed: widget.onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: widget.textColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              side: BorderSide(
                color: _hasFocus
                    ? (widget.focusBorderColor ?? widget.textColor)
                    : (widget.borderColor ?? widget.textColor),
                width: _hasFocus ? 2 : 1,
              ),
            ),
            child: Text(widget.label),
          )
        : FilledButton(
            onPressed: widget.onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: widget.backgroundColor,
              foregroundColor: widget.textColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
            child: Text(widget.label),
          );

    return Focus(
      onFocusChange: (focused) => setState(() => _hasFocus = focused),
      child: AnimatedScale(
        scale: _hasFocus ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: button,
      ),
    );
  }
}
