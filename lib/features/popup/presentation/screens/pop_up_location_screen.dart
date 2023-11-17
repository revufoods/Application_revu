import 'package:flutter/material.dart';

import '../../../../config/config.dart';

class PopUpLocationScreen extends StatelessWidget {
  const PopUpLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: 310,
        height: 600,
        decoration: const BoxDecoration(
            color: colorPrimary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            )),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Image(
              image: AssetImage('assets/koala_ubicacion.png'),
              width: 180,
            ),
            const SizedBox(height: 20),
            const Text(
              'Hey, configura \ntu ubicación',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Así podrás conocer qué comidas hay disponibles cercanas a ti.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(9.0),
                  child: Text(
                    'Buscar locales cerca',
                    style: TextStyle(
                        fontSize: 20,
                        color: colorSecondary,
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
