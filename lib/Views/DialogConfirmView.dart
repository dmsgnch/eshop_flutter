import 'dart:async';

import 'package:eshop/Models/Enums/MessageType.dart';
import 'package:eshop/Models/ViewModels/MessageView.dart';
import 'package:flutter/material.dart';

class DialogConfirmView {
  late Completer<void> _dialogCompleter;

  Future<void> ShowProductDialog(BuildContext myContext, Message message,
      String productId, Function(BuildContext, String) func) async {
    _dialogCompleter = Completer<void>();

    showDialog(
      context: myContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(GetMessageTypeName.getMessageTypeName(message.messageType)),
          content: Text(message.message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                func(myContext, productId);
                _dialogCompleter.complete();
              },
              child: const Text('Ok'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _dialogCompleter.complete();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    await _dialogCompleter.future;
  }

  Future<void> ShowUserDialog(BuildContext myContext, Message message, Function(BuildContext) func) async {
    _dialogCompleter = Completer<void>();

    showDialog(
      context: myContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
          Text(GetMessageTypeName.getMessageTypeName(message.messageType)),
          content: Text(message.message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                func(myContext);
                _dialogCompleter.complete();
              },
              child: const Text('Ok'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _dialogCompleter.complete();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    await _dialogCompleter.future;
  }
}
