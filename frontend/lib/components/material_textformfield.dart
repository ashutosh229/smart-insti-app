import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaterialTextFormField extends StatelessWidget {
  const MaterialTextFormField(
      {super.key,
      this.controller,
      this.validator,
      required this.hintText,
      this.onChanged,
      this.onSubmitted,
      this.contentPadding,
      this.hintColor,
      this.enabled,
      this.controllerLessValue,
      this.onTap,
      this.maxLength,
      this.maxLines,
      this.textAlign,
      this.inputFormatters,});

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function? onChanged;
  final Function? onSubmitted;
  final String hintText;
  final Color? hintColor;
  final EdgeInsets? contentPadding;
  final bool? enabled;
  final String? controllerLessValue;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final Function? onTap;
  final int? maxLength;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    TextEditingController substituteController = TextEditingController();
    if (controllerLessValue != null) {
      substituteController.text = controllerLessValue!;
    }
    return TextFormField(
      onTap: () => onTap != null ? onTap!() : null,
      enabled: enabled ?? true,
      controller: controller ?? substituteController,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      onChanged: (value) => onChanged != null ? onChanged!(value) : null,
      validator: (value) => validator != null ? validator!(value) : null,
      onFieldSubmitted: (value) => onSubmitted != null ? onSubmitted!(value) : null,
      cursorColor: Colors.teal.shade900,
      style: TextStyle(
        color: Colors.teal.shade900,
        fontSize: 15,
        fontFamily: "RobotoFlex",
        decoration: TextDecoration.none,
      ),
      decoration: InputDecoration(
        contentPadding: contentPadding ?? const EdgeInsets.all(20),
        hintText: hintText,
        filled: true,
        hintStyle: TextStyle(
          color: hintColor ?? Colors.teal.shade900,
          fontSize: 15,
          fontFamily: "RobotoFlex",
        ),
        fillColor: Colors.tealAccent.withOpacity(0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
