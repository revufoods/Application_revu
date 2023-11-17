import 'package:flutter/material.dart';

class Term extends StatelessWidget {
  const Term({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          // const SizedBox(
          //   height: 200,
          // ),
          Container(
            height: size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: SingleChildScrollView(
              child: Container(
                child: const Column(
                  children: [
                    SizedBox(height: 40),
                    Image(
                      image: AssetImage('assets/logo_naranja.png'),
                      width: 150,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Terminos y condiciones',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      'Uso de datos personales',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
