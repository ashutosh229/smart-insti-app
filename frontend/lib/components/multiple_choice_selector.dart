import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';




class MultipleChoiceSelector extends StatelessWidget {
  const MultipleChoiceSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchChoices.multiple();
  }
}
