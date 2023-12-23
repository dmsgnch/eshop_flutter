import 'dart:async';

import 'package:eshop/Models/ViewModels/MessageView.dart';
import 'package:flutter/material.dart';

class DialogView {
  late Completer<void> _dialogCompleter;
  
  Future<void> ShowDialog(BuildContext context, Message message, Function func) async {
    _dialogCompleter = Completer<void>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message.messageType.toString()),
          content: Text(message.message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                func();
                Navigator.of(context).pop();
                _dialogCompleter
                    .complete(); // Виклик завершення Completer при натисканні "Ok"
              },
              child: const Text('Ok'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _dialogCompleter
                    .complete(); // Виклик завершення Completer при натисканні "Ok"
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    await _dialogCompleter.future; // Очікування завершення Completer
  }
}