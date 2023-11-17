import 'package:app/features/shared/widgets/images_aliados_bakery.dart';
import 'package:app/features/shared/widgets/images_aliados_supermarket.dart';
import 'package:app/models/bakery_response.dart';
import 'package:app/models/supermarket_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../provider/auth_provider.dart';
import '../../../shared/shared.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final superMarket = Provider.of<AuthProvider>(context);

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        drawer: const Navbar(),
        appBar: AppBar(
          backgroundColor: colorPrimary,
          leading: Padding(
            padding: const EdgeInsets.only(left: 11),
            child: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  size: 40,
                  color: Colors.white,
                )),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/map');
                  },
                  icon: const Icon(
                    Icons.map_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Container(
                color: const Color.fromARGB(31, 196, 196, 196),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/icono_panaderia.png'),
                        width: 50,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'SuperMarket',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorPrimary,
                            fontSize: 25),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              FutureBuilder(
                future: superMarket.supermarket(),
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Container(
                        height: 180,
                        child: const CupertinoActivityIndicator(
                          color: colorPrimary,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    // Manejar el error aquí si es necesario
                    return Container(
                      child: const Text('Error loading data'),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Container(
                      height: 180,
                      child: const Text('No data available'),
                    );
                  }
                  final List<Supermarket> superMarket = snapshot.data;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: superMarket.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ImagesAliadoSupermarket(
                          superMarket: superMarket[index],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
