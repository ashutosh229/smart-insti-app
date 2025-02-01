import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:logger/logger.dart';

class SuggestionTextField extends StatelessWidget {
  const SuggestionTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String?>(
      builder: (context, controller, focusNode) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter branch';
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            hintText: "Enter branch",
            filled: true,
            hintStyle: TextStyle(
              color: Colors.teal.shade900,
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
      },
      itemBuilder: (BuildContext context, value) {
        return ListTile(title: Text(value ?? "Null"));
      },
      onSelected: (Object? value) {
        final logger = Logger();
        logger.i(value.toString());
      },
      suggestionsCallback: (String search) {
        return [];
      },
    );
  }
}
