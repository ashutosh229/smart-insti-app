import 'package:flutter/material.dart';

class BorderlessButton extends StatelessWidget {
  const BorderlessButton(
      {super.key,
      required this.backgroundColor,
      required this.onPressed,
      required this.splashColor,
      required this.label});

  final Color backgroundColor;
  final Color splashColor;
  final Function() onPressed;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: splashColor,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: const BorderSide(color: Colors.transparent, width: 0),
      ),
      onPressed: onPressed,
      child: IntrinsicWidth(child: label),
    );
  }
}
