import 'package:app/config/config.dart';
import 'package:flutter/material.dart';

class ThanksScreen extends StatelessWidget {
  const ThanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondary,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Thank you for purchasing',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Image.asset(
            'assets/personaje_03.png',
            width: 250,
          ),
          const Text(
            'You can now return to the main menu and go pick up your surprise return!!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: colorPrimary),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Padding(
                padding: EdgeInsets.all(9.0),
                child: Text(
                  'Go to Menu',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ))
        ],
      )),
    );
  }
}
