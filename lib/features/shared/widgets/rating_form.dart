import 'package:app/features/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';

class RatingForm extends StatefulWidget {
  final String aliadoId;
  final String branchId;

  const RatingForm({super.key, required this.aliadoId, required this.branchId});

  @override
  _RatingFormState createState() => _RatingFormState();
}

class _RatingFormState extends State<RatingForm> {
  final numberCtrl = TextEditingController();
  final commentCtrl = TextEditingController();

  // double rating = 3.0;

  @override
  Widget build(BuildContext context) {
    final ratingResponse = Provider.of<AuthProvider>(context);

    return AlertDialog(
      title: const Text('Rate ally'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Slider(
          //   value: rating,
          //   min: 1,
          //   max: 5,
          //   divisions: 4,
          //   onChanged: (newRating) {
          //     setState(() {
          //       rating = newRating;
          //     });
          //   },
          // ),
          CustomFieldInput(label: 'number', textController: numberCtrl),
          CustomFieldInput(label: 'Comment', textController: commentCtrl)

          //  onChanged: (value) {
          //     setState(() {
          //       comment = value;
          //     });
          //   },
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(); // Cierra el diálogo emergente
          },
        ),
        ElevatedButton(
          child: const Text('Send'),
          onPressed: () {
            final ratingValue = double.tryParse(numberCtrl.text);
            if (ratingValue != null) {
              ratingResponse.rating(widget.aliadoId, widget.branchId,
                  ratingValue, commentCtrl.text.trim());
            } else {
              // Manejar el caso en el que no se pudo convertir el valor a double
              // Puedes mostrar un mensaje de error o tomar otra acción apropiada.
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
