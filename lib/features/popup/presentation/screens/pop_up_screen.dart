import 'package:app/config/config.dart';
import 'package:app/features/popup/popup.dart';
import 'package:flutter/material.dart';

import '../../../shared/shared.dart';

class PopUpScreen extends StatelessWidget {
  const PopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: PageView(
        children: const [
          PopUpOneScreen(),
          PopUpTwoScreen(),
          PopUpThreeScreen(),
          PopUpFourScreen(),
        ],
      ),
    );
  }
}
