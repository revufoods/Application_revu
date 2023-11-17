import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget iconi;
  final Widget iconf;
  final String title;

  const CustomCard({
    super.key,
    required this.iconi,
    required this.iconf,
    required this.title,
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
          trailing: iconf,
        ),
      ),
    );
  }
}
