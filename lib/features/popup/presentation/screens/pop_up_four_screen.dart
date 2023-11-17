import 'package:flutter/material.dart';

import '../../../../config/config.dart';

class PopUpFourScreen extends StatelessWidget {
  const PopUpFourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 310,
      height: 550,
      decoration: const BoxDecoration(
          color: colorSecondary,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/logo_blanco_azul.png'),
            width: 130,
          ),
          SizedBox(height: 35),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Thank you for joining this revolution!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/loadingAuth');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFffc619)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Lets get started.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    ));
  }
}
