import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

class ChoiceSelector extends StatelessWidget {
  const ChoiceSelector(
      {super.key,
      required this.onChanged,
      required this.value,
      required this.items,
      required this.hint});

  final Function onChanged;
  final List<DropdownMenuItem<String>> items;
  final String? value;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: SearchChoices.single(
        style: TextStyle(
          color: Colors.teal.shade900,
          fontSize: 15,
          fontFamily: "RobotoFlex",
        ),
        items: items,
        value: value,
        hint: hint,
        searchHint: null,
        onChanged: (value) => onChanged(value),
        dialogBox: false,
        isExpanded: true,
        displayClearIcon: false,
        fieldPresentationFn: (Widget fieldWidget, {bool? selectionIsValid}) {
          return InputDecorator(
            decoration: InputDecoration(
              hintStyle: TextStyle(
                color: Colors.teal.shade900,
                fontSize: 15,
                fontFamily: "RobotoFlex",
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              isDense: true,
              filled: true,
              fillColor: Colors.tealAccent.withOpacity(0.4),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            child: fieldWidget,
          );
        },
        menuConstraints: BoxConstraints.tight(const Size.fromHeight(350)),
        validator: null,
        menuBackgroundColor: Colors.tealAccent.shade100,
      ),
    );
  }
}
