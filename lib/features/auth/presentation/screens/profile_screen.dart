import 'package:app/config/config.dart';
import 'package:app/features/provider/auth_provider.dart';
import 'package:app/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/show_alert.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)?.settings.arguments as int?;
    final nameCtrl = TextEditingController();
    final lastnameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final cellphoneCtrl = TextEditingController();

    final size = MediaQuery.of(context).size;
    final updateUser = Provider.of<AuthProvider>(context);

    return Scaffold(
        backgroundColor: colorPrimary,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 130),
              // Icon Banner
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: const Image(
                  image: AssetImage('assets/icono_koala.png'),
                  width: 100,
                ),
              ),
              const SizedBox(height: 130),

              Container(
                height: size.height - 260, // 80 los dos sizebox y 100 el ícono
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: Container(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Revusuario',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomFieldInput(
                            label: 'Name', textController: nameCtrl),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomFieldInput(
                            label: 'Last Name', textController: lastnameCtrl),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomFieldInput(
                            label: 'Email', textController: emailCtrl),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomFieldInput(
                            label: 'Cellphone', textController: cellphoneCtrl),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorPrimary),
                          onPressed: () async {
                            if (userId != null) {
                              final updateOk = await updateUser.updateUser(
                                userId,
                                nameCtrl.text.trim(),
                                lastnameCtrl.text.trim(),
                                emailCtrl.text.trim(),
                                cellphoneCtrl.text.trim(),
                              );

                              nameCtrl.text.trim();
                              lastnameCtrl.text.trim();
                              emailCtrl.text.trim();
                              cellphoneCtrl.text.trim();
                              if (updateOk == true) {
                                showAlert(
                                    context, 'Se actualizo', 'Tu información');
                              } else {
                                showAlert(context, 'Update Incorrect ',
                                    updateOk.toString());
                              }
                            }
                          },

                          //        onPressed: authProvider.autenticando
                          // ? null
                          // : () async {
                          //     FocusScope.of(context).unfocus();
                          //     final loginOk = await authProvider.login(
                          //         emailCtrl.text.trim(), passwordCtrl.text.trim());
                          //     if (loginOk == true) {
                          //       Navigator.pushReplacementNamed(context, '/');
                          //     } else {
                          //       showAlert(context, 'Incorrect credentials',
                          //           loginOk.toString());
                          //     }
                          //   },
                          child: const Padding(
                            padding: EdgeInsets.all(9.0),
                            child: Text(
                              'Save',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
