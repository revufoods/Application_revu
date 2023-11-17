import 'package:flutter/material.dart';

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.11,
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 25, left: 18),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0, backgroundColor: Colors.grey[200]),
                  onPressed: () {},
                  child: const Text(
                    'Hello world',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  )),
            );
          },
        ),
      ),
    );
  }
}
