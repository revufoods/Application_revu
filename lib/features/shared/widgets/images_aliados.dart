import 'package:app/features/provider/auth_provider.dart';
import 'package:app/helpers/show_alert.dart';
import 'package:app/models/restaurant_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';

class ImagesAliado extends StatefulWidget {
  final Restaurant restaurant;

  ImagesAliado({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  _ImagesAliadoState createState() => _ImagesAliadoState();
}

class _ImagesAliadoState extends State<ImagesAliado> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final favoritePost = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 250,
              width: 350,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, '/details', arguments: {
                  'aliadoId': widget.restaurant.id,
                  'branchId': widget.restaurant.branch.id,
                }),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(widget.restaurant.fullCoverPhoto),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
                left: 20,
                top: 10,
                child: IconButton(
                    onPressed: () async {
                      final favoriteOk = await favoritePost.favorite(
                          widget.restaurant.id, widget.restaurant.branch.id);
                      setState(() {
                        isFavorite = favoriteOk == true;
                      });
                      if (favoriteOk == true) {
                        showAlert(context, 'Favorite Successfully',
                            'Your establishment is in favorites👌');
                      } else {
                        showAlert(context, 'Incorrect', favoriteOk.toString());
                      }
                    },
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      size: 30,
                      color: colorSecondary,
                    ))),
            const Positioned(
              top: 10,
              right: 20,
              child: Row(children: [
                Icon(
                  Icons.star_border_outlined,
                  color: colorSecondary,
                  size: 30,
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
              left: 20,
              bottom: 10,
              child: Row(children: [
                CircleAvatar(
                  maxRadius: 25,
                  backgroundImage: NetworkImage(widget.restaurant.fullLogo),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.restaurant.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorPrimary,
                      fontSize: 25),
                ),
              ]),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: 350,
          child: Text(
            widget.restaurant.branch.address,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
