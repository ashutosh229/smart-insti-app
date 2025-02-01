import 'package:flutter/material.dart';

class CollapsingAppBar extends StatelessWidget {
  const CollapsingAppBar({super.key, required this.bottom, this.height, this.leading, required this.body, this.title});

  final Widget bottom;
  final double? height;
  final Widget? leading;
  final Widget body;
  final Text? title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: title,
      titleSpacing: 0,
      leading: leading,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      expandedHeight: height ?? 300,
      floating: true,
      pinned: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: bottom,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: body,
      ),
    );
  }
}
