import 'package:flutter/material.dart';

class RoundedChip extends StatelessWidget {
  const RoundedChip({super.key, required this.label, required this.onDeleted, required this.color});

  final String label;
  final Function() onDeleted;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(splashFactory: InkRipple.splashFactory,splashColor: color.withOpacity(0.5)),
      child: Chip(
        label: Text(label),
        onDeleted: () => onDeleted(),
        side: BorderSide.none,
        color: MaterialStateProperty.all<Color>(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide.none,
        ),
      ),
    );
  }
}
