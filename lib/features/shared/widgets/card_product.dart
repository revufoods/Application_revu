import 'package:app/models/restaurant_response.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart';

class CardProduct extends StatelessWidget {
  final Restaurant restaurantShow;
  const CardProduct({
    super.key,
    required this.restaurantShow,
  });

  @override
  Widget build(BuildContext context) {
    // print(restaurantShow.id);
    return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Column(
          children: [
            Stack(
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(restaurantShow.fullCoverPhoto),
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned(
                  top: 10,
                  right: 10,
                  child: Row(children: [
                    Icon(
                      Icons.star_border_outlined,
                      color: colorSecondary,
                    ),
                    SizedBox(width: 3),
                    Text(
                      '4.5',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ]),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: Row(children: [
                    CircleAvatar(
                      maxRadius: 25,
                      // backgroundColor: colorSecondary,
                      backgroundImage: NetworkImage(restaurantShow.fullLogo),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      restaurantShow.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25),
                    ),
                  ]),
                )
              ],
            ),
            Container(
              // alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    restaurantShow.branch.address,
                    style: const TextStyle(fontSize: 11.5),
                  ),
                  const SizedBox(height: 15),
                  const Icon(
                    Icons.favorite_border_outlined,
                    size: 30,
                    color: colorSecondary,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
