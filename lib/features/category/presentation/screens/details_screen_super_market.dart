import 'package:app/config/config.dart';
import 'package:app/features/provider/auth_provider.dart';
import 'package:app/models/revu_sorpresa_response.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../helpers/show_alert.dart';
import '../../../../models/bakery_details_responase.dart';
import '../../../shared/shared.dart';

class DetailsSuperMarketScreen extends StatelessWidget {
  const DetailsSuperMarketScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final marketAliado = Provider.of<AuthProvider>(context);
    final Map<String, dynamic> superMarketResponse =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final aliadoId = superMarketResponse['aliadoId'];
    final branchId = superMarketResponse['branchId'];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Super Market details'),
          backgroundColor: colorPrimary,
        ),
        body: FutureBuilder<BakeryAliado?>(
          future: marketAliado.bakeryAliado(aliadoId, branchId),
          builder: (_, AsyncSnapshot<BakeryAliado?> snapshot) {
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

            final BakeryAliado? aliadoshowB = snapshot.data;

            if (aliadoshowB == null) {
              return const Center(
                child: Text("No se encontraron datos"),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    child: Stack(
                      children: [
                        Image(image: NetworkImage(aliadoshowB.fullCoverPhoto)),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: CircleAvatar(
                            maxRadius: 35,
                            backgroundImage: NetworkImage(aliadoshowB.fullLogo),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    aliadoshowB.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: colorPrimary,
                    ),
                  ),
                  FutureBuilder<RevuSopresa?>(
                    future: marketAliado.revuSopresaBakery(aliadoId, branchId),
                    builder: (_, AsyncSnapshot<RevuSopresa?> revuSnapshot) {
                      if (revuSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Container(
                            height: 180,
                            child: const CupertinoActivityIndicator(
                              color: colorPrimary,
                            ),
                          ),
                        );
                      }

                      final RevuSopresa? revuSorpresaAliado = revuSnapshot.data;

                      if (revuSorpresaAliado == null) {
                        return const Center(
                          child:
                              Text("This establishment has no surprise Revu"),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: revuSorpresaAliado.images!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final image = revuSorpresaAliado.images![index];
                              return Image.network(
                                image.url,
                                width: 150,
                                height: 150,
                              ); // Muestra la imagen desde la URL
                            },
                          ),
                          const SizedBox(height: 15),
                          Text(
                            revuSorpresaAliado.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(
                                width: 60,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '\$',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: revuSorpresaAliado.price.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.grey,
                                        decorationThickness: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 25),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(
                                width: 60,
                              ),
                              const Text(
                                '\$',
                                style: TextStyle(
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(
                                revuSorpresaAliado.revuPrice.toString(),
                                style: const TextStyle(
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              const SizedBox(width: 25),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Pick up time: ',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                width: 60,
                              ),
                              Text(
                                revuSorpresaAliado.startPickupTime.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(width: 5),
                              const Text('-'),
                              const SizedBox(width: 5),
                              Text(
                                revuSorpresaAliado.endPickupTime.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorPrimary,
                            ),
                            onPressed: marketAliado.autenticando
                                ? () => {}
                                : () async {
                                    // Mostrar el AlertDialog con indicador de carga
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircularProgressIndicator(), // Indicador de carga
                                              SizedBox(height: 16.0),
                                              Text('Processing Purchase...'),
                                            ],
                                          ),
                                        );
                                      },
                                    );

                                    // Retrasar el cierre del AlertDialog durante 1.5 segundos
                                    await Future.delayed(Duration(
                                        seconds: 1, milliseconds: 500));

                                    // Cerrar el AlertDialog
                                    Navigator.of(context).pop();

                                    // Realizar la compra
                                    List<Map<String, dynamic>> products = [
                                      {
                                        "id": revuSorpresaAliado.id,
                                        "amount": 1,
                                      },
                                      // Agrega más productos si es necesario
                                    ];
                                    final buyOk =
                                        await marketAliado.payment(products);

                                    if (buyOk) {
                                      Navigator.pushReplacementNamed(
                                          context, '/thanks');
                                    } else {
                                      // Mostrar alerta
                                      showAlert(context, 'Error',
                                          'The purchase could not be made');
                                    }
                                  },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Buy',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorPrimary),
                      onPressed: () {},
                      child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Buy',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          )))
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            shape: const StadiumBorder(),
            onPressed: () async {
              final result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RatingForm(
                    aliadoId: aliadoId,
                    branchId: branchId,
                  );
                },
              );
              if (result != null) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Calificación enviada '),
                  duration: const Duration(seconds: 3),
                ));
              }
            },
            child: const Icon(
              Icons.star_border,
              color: colorPrimary,
              size: 40,
            )));
  }
}
