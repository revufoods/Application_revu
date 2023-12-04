import 'package:app/config/config.dart';
import 'package:app/features/provider/auth_provider.dart';
import 'package:app/features/shared/shared.dart';
import 'package:app/models/user_put_response.dart';
import 'package:app/models/usuario_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/show_alert.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Usuario userInfo = Usuario(
    names: '',
    lastNames: '',
    email: '',
    cellphone: '',
    status: true,
    role: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    id: '',
  );
  bool _isInit = true;
  var nameCtrl = TextEditingController();
  var lastnameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var cellphoneCtrl = TextEditingController();

  String userInfoId = '';


  void getUserInfo() async {
    final user = Provider.of<AuthProvider>(context);
    try {
      final userResponse = await user.userInfo();
      userInfo = userResponse.data;
      userInfoId = userResponse.data.id;
      nameCtrl.text = userInfo.names;
      lastnameCtrl.text = userInfo.lastNames;
      emailCtrl.text = userInfo.email;
      cellphoneCtrl.text = userInfo.cellphone;

      setState(() {});
    } catch (error) {
      debugPrint(error.toString());
    }
  }


  @override
  void didChangeDependencies() {
    if (_isInit) {
      getUserInfo();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

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
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Image(
                image: AssetImage('assets/icono_koala.png'),
                width: 100,
              ),
            ),
            const SizedBox(height: 130),
            Container(
              height: size.height - 260,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Revusuario',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CustomFieldInput(
                      label: 'Name',
                      textController: nameCtrl,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CustomFieldInput(
                      label: 'Last Name',
                      textController: lastnameCtrl,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CustomFieldInput(
                      label: 'Email',
                      textController: emailCtrl,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CustomFieldInput(
                      label: 'Cellphone',
                      textController: cellphoneCtrl,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimary,
                    ),
                    onPressed: () async {
                      if (userInfoId != '') {
                        final updateOk = await updateUser.updateUser(
                          userInfoId,
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
                          showAlert(context, 'Se actualizo', 'Tu información');
                        } else {
                          showAlert(context, 'Update Incorrect ',
                              updateOk.toString());
                        }
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(9.0),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
