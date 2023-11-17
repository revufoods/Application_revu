import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  final String image;
  const CustomBackground({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
    );
  }
}
