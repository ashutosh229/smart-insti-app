import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  const ImageTile(
      {super.key,
      this.icon,
      required this.onTap,
      required this.primaryColor,
      required this.secondaryColor,
      this.body,
      this.contentPadding,
      this.image});

  final Image? image;
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
              child: Container(
                padding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                        const SizedBox(height: 20),
                        image != null
                            ? ClipRRect(borderRadius: BorderRadius.circular(10), child: image)
                            : Container(
                                width: double.infinity,
                                height: 115,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: const Icon(Icons.image, size: 50, color: Colors.black45),
                              ),
                        const SizedBox(height: 10),
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
