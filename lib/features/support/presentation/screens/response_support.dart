import 'package:app/models/admin_support_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../provider/provider.dart';

class ResponseSupport extends StatelessWidget {
  const ResponseSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final supportGet = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Support response'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.5),
        child: FutureBuilder<AdminSupportResponse>(
          future: supportGet.getSupport(),
          builder: (context, AsyncSnapshot<AdminSupportResponse> snapshot) {
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

            return Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  final item = dataList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          item.question.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              color: colorPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          item.answer?.isEmpty == true
                              ? 'Waiting answer'
                              : item.answer ?? 'You still don´t have an answer',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
