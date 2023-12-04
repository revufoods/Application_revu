// ignore_for_file: use_build_context_synchronously

import 'package:app/features/provider/provider.dart';
import 'package:app/helpers/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../shared/shared.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: colorSecondary,
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 130),
                  // Icon Banner
                  const Image(
                    image: AssetImage('assets/logo_blanco_azul.png'),
                    width: 150,
                  ),
                  const SizedBox(height: 130),
                  Container(
                    height:
                        size.height - 260, // 80 los dos sizebox y 100 el ícono
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: const _LoginForm(),
                  )
                ],
              ),
            )));
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({super.key});

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _keyValidate = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
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
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        key: _keyValidate,
        child: Column(
          children: [
            const SizedBox(height: 90),
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
              icon: const Icon(
                Icons.email_outlined,
                size: 25,
                color: Colors.grey,
              ),
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              textController: emailCtrl,
            ),
            const SizedBox(height: 30),
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
              icon: const Icon(
                Icons.lock_open_rounded,
                size: 25,
                color: Colors.grey,
              ),
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
            const SizedBox(height: 30),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: colorPrimary),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_keyValidate.currentState?.validate() == true) {
                      final loginOk = await authProvider.login(
                        emailCtrl.text.trim(),
                        passwordCtrl.text.trim(),
                      );

                      if (loginOk == true) {
                        Navigator.pushReplacementNamed(context, '/');
                      } else {
                        showAlert(context, 'Incorrect credentials',
                            loginOk.toString());
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
            const Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Forgot your password?'),
                TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/restore'),
                    child: const Text('retrieve it here'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Dont have an account?'),
                TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: const Text('Create one here'))
              ],
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
