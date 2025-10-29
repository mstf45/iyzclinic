import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFromField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final Color? fillColor;
  final double borderRadius;
  final EdgeInsetsGeometry contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;

  const CustomTextFromField({
    super.key,
    this.controller,
    this.inputFormatters,
    this.autovalidateMode,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.fillColor,
    this.borderRadius = 12.0,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 14,
      horizontal: 16,
    ),
  });

  OutlineInputBorder _border(BuildContext context, {Color? color}) {
    final c = color ?? Theme.of(context).colorScheme.outline.withOpacity(0.6);
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: c, width: 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveFill =
        fillColor ?? theme.colorScheme.surfaceContainerHighest.withOpacity(0.4);

    return Material(
      color: Colors.transparent,
      child: TextFormField(
        autovalidateMode: autovalidateMode,
        onTapUpOutside: (event) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        inputFormatters: inputFormatters,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        readOnly: readOnly,
        enabled: enabled,
        maxLines: maxLines,
        maxLength: maxLength,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        cursorColor: theme.colorScheme.primary,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: effectiveFill,
          prefixIcon: prefixIcon != null
              ? Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 4.0),
            child: IconTheme(
              data: IconThemeData(color: theme.colorScheme.primary),
              child: prefixIcon!,
            ),
          )
              : null,
          suffixIcon: suffixIcon != null
              ? Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 4.0),
            child: IconTheme(
              data: IconThemeData(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              child: suffixIcon!,
            ),
          )
              : null,
          contentPadding: contentPadding,
          isDense: true,
          border: _border(context),
          enabledBorder: _border(context),
          focusedBorder: _border(context, color: theme.colorScheme.primary),
          errorBorder: _border(context, color: theme.colorScheme.error),
          focusedErrorBorder: _border(context, color: theme.colorScheme.error),
          errorStyle: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.error,
          ),
          counterText:
          '', // hide counter by default; remove if you want visible counter
        ),
      ),
    );
  }
}
