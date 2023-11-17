// ignore_for_file: use_build_context_synchronously

import 'package:app/features/provider/provider.dart';
import 'package:app/helpers/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../shared/shared.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        const CustomBackground(image: 'assets/bg_azul.png'),
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80),
              Container(
                height: size.height - 80,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: _Form(),
              )
            ],
          ),
        )
      ],
    ));
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final nameCtrl = TextEditingController();
  final last_NameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final cellPhoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final _keyValidate = GlobalKey<FormState>();

  bool? _swiches = false;

  bool obscureText = true;

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Form(
        key: _keyValidate,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: const Column(children: [
                Text(
                  'We welcome you!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xffffa500),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 7),
                Text(
                  'Discover a new way of eating edibles with Revu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 8),
            CustomFieldInput(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }

                return null;
              },
              label: 'Name',
              textController: nameCtrl,
            ),
            CustomFieldInput(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Last name is required';
                }

                return null;
              },
              label: 'Last Name',
              textController: last_NameCtrl,
            ),
            CustomFieldInput(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                final emailRegExp = RegExp(
                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                );

                if (!emailRegExp.hasMatch(value)) {
                  return 'Enter a valid email address.';
                }
                return null;
              },
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              textController: emailCtrl,
            ),
            CustomFieldInput(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Cellphone is required';
                }

                return null;
              },
              label: 'cell',
              textController: cellPhoneCtrl,
            ),
            CustomFieldInput(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }

                if (value.length < 8) {
                  return 'The password must be at least 8 characters';
                }
                return null;
              },
              sufix: GestureDetector(
                onTap: togglePasswordVisibility,
                child: Icon(
                  obscureText
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye,
                  size: 25,
                  color: Colors.grey,
                ),
              ),
              label: 'Password',
              obscureText: obscureText,
              textController: passwordCtrl,
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              activeColor: const Color(0xffffa500),
              value: _swiches,
              onChanged: (value) {
                setState(() {
                  _swiches =
                      value; // Actualiza el valor del _swiches cuando se cambia el estado del cuadro de verificación
                });
              },
              title: const Text(
                  'You authorize the processing of your personal data. Learn about our data processing policy.'),
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: 60,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: colorSecondary),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_keyValidate.currentState?.validate() == true) {
                      final registerOK = await authProvider.register(
                          nameCtrl.text.trim(),
                          last_NameCtrl.text.trim(),
                          emailCtrl.text.trim(),
                          cellPhoneCtrl.text.trim(),
                          passwordCtrl.text.trim());
                      nameCtrl.clear();
                      last_NameCtrl.clear();
                      emailCtrl.clear();
                      cellPhoneCtrl.clear();
                      passwordCtrl.clear();

                      if (registerOK == true) {
                        showAlert(context, 'user created successfully',
                            'you can enter');
                      } else {
                        showAlert(context, 'Incorrect user creation',
                            registerOK.toString());
                      }
                    }
                  },
                  child: const Text(
                    'Ready, let`s go in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Have an account?'),
                TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: const Text('return to login'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
