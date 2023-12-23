import 'dart:async';
import 'dart:io';

import 'package:eshop/Models/Enums/MessageType.dart';
import 'package:eshop/Models/ViewModels/MessageView.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SimpleDialogView {
  List<Message> messages = [];
  late Completer<void> _dialogCompleter;

  void AddNewMessage(MessageType messageType, String message) {
    messages.add(Message(messageType, message));
  }

  void DisplayAllMessageInList(BuildContext context) {
    if (messages.isEmpty) return;

    for (var message in messages) {
      ShowDialog(context, message);
    }

    messages = [];
  }

  Future<void> ShowDialog(BuildContext context, Message message) async {
    _dialogCompleter = Completer<void>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              GetMessageTypeName.getMessageTypeName(message.messageType),
              style: const TextStyle(color: Colors.white70, fontSize: 20)),
          backgroundColor: const Color.fromRGBO(33, 39, 42, 1),
          content: Text(message.message,
              style: const TextStyle(fontSize: 14, color: Colors.grey)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _dialogCompleter
                    .complete();
              },
              child: const Text('Ok', style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );

    await _dialogCompleter.future; // Очікування завершення Completer
  }
}
