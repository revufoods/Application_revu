import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/config.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  // Future<void> postSupport(String mensaje, String token) async {
  //   final respuesta = await Dio()
  //       .post('http://localhost:8000/api#/auth/AuthController_loginMobile',
  //           queryParameters: {"mensaje": mensaje},
  //           options: Options(headers: {
  //             "Content-type": "application/json",
  //             "authorization": "Barer $token",
  //           }));
  // }

  @override
  Widget build(BuildContext context) {
    final style = const TextStyle(fontSize: 15, color: Colors.black);
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg_azul.png'), fit: BoxFit.cover)),
        ),
        SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
            children: [
              const Text(
                'FAQs',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ExpansionTileCard(
                title: const Text('Where can I edit my profile?'),
                leading: const Image(
                  image: AssetImage('assets/icono_persona.png'),
                  width: 25,
                ),
                children: [
                  const Divider(
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Text(
                          'Open the app menu that is located in the upper left side and tap “profile.” There you can edit your name, phone number, and email.',
                          style: style),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              ExpansionTileCard(
                title: const Text('How can I post a concern on my reserve?'),
                leading: const Image(
                  image: AssetImage('assets/icono_bolsa.png'),
                  width: 25,
                ),
                children: [
                  const Divider(
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'Open the app menu that is located in the upper left side and tap “support.” There you can leave a message about your concern.',
                        style: style,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              ExpansionTileCard(
                title: const Text('How does REVU work?'),
                leading: const Image(
                  image: AssetImage('assets/icono_mobile.png'),
                  width: 25,
                ),
                children: [
                  const Divider(
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          children: [
                            Text(
                              'Revu is an app that prevents food waste by connecting food producers with its consumers.',
                              style: style,
                            ),
                            Text(
                              'In our platform you can give a second chance to products that would have been thrown away otherwise (nearly expiring products or surplus production). Products that’s had not been manipulated by consumers and in good condition..',
                              style: style,
                            ),
                            Text(
                              'You just need too reserve your revu surprise and pick it up.',
                              style: style,
                            ),
                          ],
                        )),
                  )
                ],
              ),
              const SizedBox(height: 10),
              ExpansionTileCard(
                title:
                    const Text('I want to save food with REVU how do I join?'),
                leading: const Image(
                  image: AssetImage('assets/icono_aliado.png'),
                  width: 25,
                ),
                children: [
                  const Divider(
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'It’s easy. Go to our web site. Tap in the right upper side “login”. Tap in “register” and upload all the information that’s we need to consider you part of Revu family.',
                        style: style,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: colorSecondary),
                  onPressed: () {
                    Navigator.pushNamed(context, '/messagesupport');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(
                          image: AssetImage('assets/icono_audifono02.png'),
                          width: 40,
                        ),
                        Text(
                          'I need HELP',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        )
      ],
    ));
  }
}
