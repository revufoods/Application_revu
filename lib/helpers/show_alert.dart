import 'dart:io';

import 'package:app/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlert(BuildContext context, String title, String subtitle) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(subtitle),
              actions: [
                MaterialButton(
                  textColor: colorPrimary,
                  elevation: 5,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('ok'),
                )
              ],
            ));
  }
  showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('ok'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ));
}
