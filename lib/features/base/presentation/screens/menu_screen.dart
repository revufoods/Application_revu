import 'package:app/config/config.dart';
import 'package:app/models/restaurant_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';
import '../../../shared/shared.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final menuProvider = Provider.of<AuthProvider>(context);
    // print(menuProvider.restaurant());

    return Scaffold(
        key: _scaffoldKey,
        drawer: const Navbar(),
        appBar: AppBar(
          backgroundColor: colorSecondary,
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
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Card(
                clipBehavior: Clip.none,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 37, vertical: 15),
                  child: Text(
                    'How’s your day? Place your order \n today with Revu and enjoy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Container(
                color: const Color.fromARGB(31, 196, 196, 196),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/restaurant'),
                              icon: const Image(
                                image: AssetImage('assets/icono_comida.png'),
                                width: 43,
                              )),
                          const Text('Restaurant',
                              style: TextStyle(color: Colors.black45))
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/bakery'),
                              icon: const Image(
                                image: AssetImage('assets/icono_panaderia.png'),
                                width: 40,
                              )),
                          const Text('Bakery',
                              style: TextStyle(color: Colors.black45))
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/market');
                              },
                              icon: const Image(
                                image: AssetImage('assets/icono_mercado.png'),
                                width: 32,
                              )),
                          const Text('SuperMarket',
                              style: TextStyle(color: Colors.black45))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              FutureBuilder(
                future: menuProvider.restaurant(),
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: 180,
                      child: const CupertinoActivityIndicator(
                        color: colorPrimary,
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
                  final List<Restaurant> restaurant = snapshot.data;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurant.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ImagesAliado(
                          restaurant: restaurant[index],
                        );
                      },
                    ),
                  );
                },
              ),
              const Spacer(),
              const Image(image: AssetImage('assets/mesa.png'))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            shape: const StadiumBorder(),
            onPressed: () => Navigator.pushNamed(context, '/support'),
            child: const Icon(
              Icons.support_agent_outlined,
              color: colorPrimary,
              size: 40,
            )));
  }
}
