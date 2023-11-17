// ignore_for_file: use_build_context_synchronously

import 'package:app/features/provider/provider.dart';
import 'package:app/helpers/show_alert.dart';
import 'package:app/models/admin_support_response.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../shared/shared.dart';

class MessageSupportScreen extends StatelessWidget {
  const MessageSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 15, color: Colors.black);

    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: const FormSupport(style: style));
  }
}

class FormSupport extends StatefulWidget {
  const FormSupport({
    super.key,
    required this.style,
  });

  final TextStyle style;

  @override
  State<FormSupport> createState() => _FormSupportState();
}

final supportCtrl = TextEditingController();

class _FormSupportState extends State<FormSupport> {
  @override
  Widget build(BuildContext context) {
    final support = Provider.of<AuthProvider>(context);
    return Column(
      children: [
        const SizedBox(
          height: 250,
        ),
        const Text(
          'Do you need help?',
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            'Get in touch with Revu support.',
            style: TextStyle(fontSize: 28, color: Colors.black),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(60.0),
            child: CustomFieldInput(
              textController: supportCtrl,
              label: 'How can we assist you?',
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: colorPrimary),
            onPressed: support.autenticando
                ? null
                : () async {
                    final supportOk =
                        await support.support(supportCtrl.text.trim());
                    supportCtrl.clear();

                    if (supportOk) {
                      return showAlert(context, 'Support sent',
                          'We will respond to you very soon. 👍');
                    }
                  },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'Send',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            )),
        const SizedBox(height: 50),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: colorSecondary),
            onPressed: () {
              Navigator.pushNamed(context, '/answerSupport');
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'Your answers',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            )),
      ],
    );
  }
}
