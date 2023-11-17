import 'package:app/features/provider/provider.dart';
import 'package:app/models/usuario_response.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  AsyncSnapshot<UsuarioResponse>? _userSnapshot;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final usuario = authProvider.usaurio();
    const style = TextStyle(fontSize: 18, color: Colors.black54);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder(
            future: usuario,
            builder: (context, AsyncSnapshot<UsuarioResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print(snapshot.connectionState);
                return const Center(
                    child:
                        CircularProgressIndicator()); // Muestra un indicador de carga mientras espera los datos.
              } else {
                print(snapshot.data?.data.id);
                return UserAccountsDrawerHeader(
                  currentAccountPicture:
                      const Image(image: AssetImage('assets/personaje_03.png')),
                  accountName: Text(
                      'Hola ${snapshot.data?.data.names} ${snapshot.data?.data.lastNames}'),
                  accountEmail: Text('${snapshot.data?.data.email}'),
                  decoration: const BoxDecoration(color: colorSecondary),
                );
              }
            },
          ),
          ListTile(
              title: Text('My profile', style: style),
              onTap: () {
                final userId = _userSnapshot?.data?.data.id;
                print(_userSnapshot?.data?.data.id);
                Navigator.pushNamed(context, '/profile', arguments: userId);
              }),
          // ListTile(
          //   title: const Text('Notifications', style: style),
          //   onTap: () =>
          //       Navigator.pushNamed(context, '/notifications'),
          // ),
          ListTile(
            title: const Text('Favorites',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () => Navigator.pushNamed(context, '/favorite'),
            trailing: const Icon(
              Icons.favorite,
              color: colorSecondary,
            ),
          ),
          ListTile(
            title: const Text('Support - FAQ', style: style),
            onTap: () => Navigator.pushNamed(context, '/support'),
          ),
          ListTile(
            title: const Text('Privacy policies', style: style),
            onTap: () => Navigator.pushNamed(context, '/policy'),
          ),
          ListTile(
            title: const Text('Terms and conditions', style: style),
            onTap: () => Navigator.pushNamed(context, '/term'),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.instagram,
                    color: colorPrimary,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.tiktok,
                      color: colorPrimary)),
              IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.facebook,
                      color: colorPrimary)),
              IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.twitter,
                      color: colorPrimary)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 80),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0.5),
                onPressed: () async {
                  await authProvider.logOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text(
                  'Log out',
                  style: style,
                )),
          )
        ],
      ),
    );
  }
}
