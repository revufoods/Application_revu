import 'package:app/models/favorite_response_get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
        backgroundColor: colorSecondary,
      ),
      body: const InfoFavorite(),
    );
  }
}

class InfoFavorite extends StatelessWidget {
  const InfoFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<AuthProvider>(context);

    return FutureBuilder<FavoriteResponseGet>(
      future: favorite.getFavorite(),
      builder: (context, AsyncSnapshot<FavoriteResponseGet> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: colorPrimary,
            ),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading data'),
          );
        }
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.data.isEmpty) {
          return const Center(
            child: Text('No data available'),
          );
        }

        final dataList = snapshot.data!.data;

        return Column(
          children: [
            const Text(
              'My favorites',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  final item = dataList[index];
                  return ListTile(
                    title: Text(item.businesse),
                    subtitle: Text(item.branch.address),
                    leading: Image.network(item.fullLogofavorite),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
