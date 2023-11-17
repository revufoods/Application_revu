import 'package:flutter/material.dart';

import '../../../../config/config.dart';

class PopUpTwoScreen extends StatelessWidget {
  const PopUpTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 310,
      height: 550,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45))),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/personaje_02.png'),
            width: 200,
          ),
          SizedBox(
            height: 40,
          ),
          Text('The change is in everyone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: colorSecondary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
                'We dream of reducing food waste in Estados Unidos, giving surplus production a second chance.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17, color: Colors.black54, height: 1.4)),
          )
        ],
      ),
    ));
  }
}
