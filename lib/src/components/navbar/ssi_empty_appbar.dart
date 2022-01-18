import 'package:flutter/material.dart';

class SsiEmptyAppBar extends PreferredSize {
  final double height;
  final Color? color;

  SsiEmptyAppBar(this.height, {Key? key, this.color})
      : super(
            key: key,
            child: Container(
              color: color ?? Colors.white,
            ),
            preferredSize: Size.fromHeight(height));

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.white,
    );
  }
}
