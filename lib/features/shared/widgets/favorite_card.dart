import 'package:flutter/material.dart';

class FavoriteCard extends StatelessWidget {
  final Widget iconi;

  final String title;
  final String subTitle;

  const FavoriteCard({
    super.key,
    required this.iconi,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontWeight: FontWeight.bold);

    return Card(
      elevation: 2,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          leading: iconi,
          title: Text(
            title,
            style: style,
          ),
          subtitle: Text(
            subTitle,
          ),
        ),
      ),
    );
  }
}
