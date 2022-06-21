library flashcards_app.frontend.dialogs;


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

  /// alerts the user that something has happened
  /// 
  /// Yes => true
  /// No => false
  /// Cancel => null
  static Future<bool?> yesNoCancel(BuildContext context, String message) => showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Yes"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text("Cancel"),
        )
      ]
    )
  );







}