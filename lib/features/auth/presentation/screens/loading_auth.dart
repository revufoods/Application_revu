// ignore_for_file: use_build_context_synchronously

import 'package:app/features/auth/auth.dart';
import 'package:app/features/base/base.dart';
import 'package:app/features/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingAuth extends StatelessWidget {
  const LoadingAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
            child: Image(
              image: AssetImage('assets/logo_azul.png'),
              width: 150,
            ),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthProvider>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      // TODO: conectar al socket server
      // Navigator.pushNamed(context, 'usuarios');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => MenuScreen(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginScreen(),
              transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
