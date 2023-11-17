import 'package:app/features/provider/auth_provider.dart';
import 'package:app/helpers/show_alert.dart';
import 'package:app/models/supermarket_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';

class ImagesAliadoSupermarket extends StatefulWidget {
  final Supermarket superMarket;

  ImagesAliadoSupermarket({
    Key? key,
    required this.superMarket,
  }) : super(key: key);

  @override
  _ImagesAliadoSupermarketState createState() =>
      _ImagesAliadoSupermarketState();
}

class _ImagesAliadoSupermarketState extends State<ImagesAliadoSupermarket> {
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
                    Navigator.pushNamed(context, '/detailsMarket', arguments: {
                  'aliadoId': widget.superMarket.id,
                  'branchId': widget.superMarket.branch.id,
                }),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(widget.superMarket.fullCoverPhoto),
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
                          widget.superMarket.id, widget.superMarket.branch.id);
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
                  backgroundImage: NetworkImage(widget.superMarket.fullLogo),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.superMarket.name,
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
            widget.superMarket.branch.address,
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
