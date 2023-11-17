import 'package:app/config/config.dart';
import 'package:flutter/material.dart';

class CustomBottonSupport extends StatelessWidget {
  const CustomBottonSupport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        shape: const StadiumBorder(),
        backgroundColor: Colors.white,
        onPressed: () => Navigator.pushNamed(context, '/support'),
        child: const Icon(
          Icons.support_agent,
          color: colorPrimary,
          size: 40,
        ));
  }
}
