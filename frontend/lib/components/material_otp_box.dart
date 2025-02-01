import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaterialOTPBox extends StatelessWidget {
  const MaterialOTPBox(
      {super.key, required this.controller, required this.focusNode, required this.hintText, this.onChanged});

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.0,
      height: 60.0,
      child: TextFormField(
        showCursor: false,
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
        keyboardType: TextInputType.number,
        expands: true,
        maxLines: null,
        maxLength: null,
        style: const TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w300,
        ),
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 30.0,
            fontFamily: 'Poppins',
            color: Colors.black12,
            fontWeight: FontWeight.w300,
          ),
          filled: true,
          fillColor: Colors.lightBlueAccent.withOpacity(0.4),
          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
