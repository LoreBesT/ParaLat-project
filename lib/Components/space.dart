import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  const Space({super.key, required this.heigth, this.width});
  final double heigth;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heigth,
      width: width,
    );
  }
}
