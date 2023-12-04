// ignore_for_file: use_build_context_synchronously

import 'package:app/features/provider/provider.dart';
import 'package:app/helpers/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../shared/shared.dart';

class RestoreScreen extends StatelessWidget {
  const RestoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/logo_blanco_azul.png'),
              width: 150,
            ),
            const SizedBox(height: 50),
            Container(
              height: 450,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(
                        5,
                        5,
                      ),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  )),
              child: const FormRestore(),
            )
          ],
        ),
      ),
    );
  }
}

class FormRestore extends StatefulWidget {
  const FormRestore({
    super.key,
  });

  @override
  State<FormRestore> createState() => _FormRestoreState();
}

class _FormRestoreState extends State<FormRestore> {
  final restoreCtrl = TextEditingController();
  final _keyValidate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Form(
      key: _keyValidate,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 15),
          const Image(
            image: AssetImage('assets/icono_candado.png'),
            width: 40,
          ),
          const Text(
            'Recover your password',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: colorSecondary),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: CustomFieldInput(
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
                label: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                textController: restoreCtrl),
          ),
          SizedBox(
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: colorPrimary),
                onPressed: () async {
                  FocusScope.of(context).unfocus();

                  if (_keyValidate.currentState?.validate() == true) {
                    final recoverOk = await authProvider
                        .recoverPassword(restoreCtrl.text.trim());
                    restoreCtrl.clear();

                    if (recoverOk == true) {
                      showAlert(context, 'Link sent', 'Check your email');
                    } else {
                      showAlert(
                          context, 'Email incorrect', recoverOk.toString());
                    }
                  }
                },
                child: const Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          TextButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text('back to login'))
        ],
      ),
    );
  }
}
