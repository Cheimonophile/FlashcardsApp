library flashcards_app.backend.dialogs;


import 'package:flutter/material.dart';

class Dialogs {

  /// alerts the user that something has happened
  static Future<void> alert(BuildContext context, String message) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: Text(message),
      actions: <Widget>[TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('OK'),
      )]
    )
  );


  /// alerts the user that something has happened
  static Future<bool?> permission(BuildContext context, String message) => showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('OK'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        )
      ]
    )
  );







}