import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  const MenuTile(
      {super.key,
      required this.title,
      this.icon,
      required this.onTap,
      required this.primaryColor,
      required this.secondaryColor,
      this.body,
      this.contentPadding});

  final String title;
  final List<Widget>? body;
  final IconData? icon;
  final Function onTap;
  final EdgeInsets? contentPadding;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        child: Ink(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: primaryColor),
          child: InkWell(
            overlayColor: MaterialStateProperty.all<Color?>(secondaryColor),
            borderRadius: BorderRadius.circular(15),
            splashColor: secondaryColor,
            onTap: () => onTap(),
            child: Center(
              child: Padding(
                padding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: "GoogleSansFlex",
                          ),
                        ),
                      ] +
                      (body ?? []),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
