import 'package:flutter/material.dart';

class CardCredit extends StatelessWidget {
  final Widget leanding;
  final String title;
  final String subTitle;
  final String image;

  const CardCredit({
    super.key,
    required this.leanding,
    required this.title,
    required this.subTitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Card(
        color: Colors.white,
        child: ListTile(
            leading: Image(image: AssetImage(image)),
            title: Text(title),
            subtitle: Text(subTitle),
            trailing: leanding),
      ),
    );
  }
}
