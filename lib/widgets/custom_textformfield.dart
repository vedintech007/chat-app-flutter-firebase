import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_app/shared/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.maxLength,
    this.autofocus,
    this.obscureText,
    this.autocorrect,
    this.showCursor,
    this.readOnly,
    this.cursorWidth,
    this.cursorHeight,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.hintStyle,
    this.style,
    this.inputFormatters,
    this.keyboardType,
    this.cursorColor,
    this.cursorRadius,
    this.contentPadding,
    this.floatingLabelBehavior,
    this.prefix,
    this.prefixStyle,
    this.suffix,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixStyle,
    this.maxLines,
    this.focusNode,
    this.autovalidateMode,
    this.prefixIconColor,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onTap;
  final int? maxLength;
  final bool? autofocus;
  final bool? obscureText;
  final bool? autocorrect;
  final bool? showCursor;
  final bool? readOnly;
  final double? cursorWidth;
  final double? cursorHeight;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Color? cursorColor;
  final Radius? cursorRadius;
  final EdgeInsetsGeometry? contentPadding;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Widget? prefix;
  final TextStyle? prefixStyle;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? prefixIconColor;

  final TextStyle? suffixStyle;
  final int? maxLines;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction = TextInputAction.next;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: cursorColor,
      autocorrect: autocorrect ?? false,
      obscureText: obscureText ?? false,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      validator: validator,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.black),
        label: Text(label ?? ""),
        prefix: prefix,
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors().primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors().primaryRedColor,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors().primaryRedColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors().primaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
