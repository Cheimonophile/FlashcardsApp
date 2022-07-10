library flashcards_app.frontend.visual_utils;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

abstract class Util {
  static Widget wheel = const Padding(
    padding: EdgeInsets.all(8.0),
    child: Center(child: CircularProgressIndicator()),
  );

  static Widget todo = const Padding(
    padding: EdgeInsets.all(8.0),
    child: Center(child: Text("<To Do>")),
  );

  static InputDecoration textInputDecoration = const InputDecoration(
    filled: true,
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.all(8.0),
    isDense: true,
    hintText: "0",
  );

  static TextInputFormatter get numberInputFormatter => _NumberInputFormatter();

  static InputDecoration searchDecoration = const InputDecoration(
    prefixIcon: Icon(Icons.search),
    hintText: "Search",
    filled: true,
    border: OutlineInputBorder(),
    isDense: true,
  );

  static Widget multilineTextField(TextEditingController? controller) =>
      TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        expands: true,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.top,
        decoration: const InputDecoration(
          filled: true,
          border: OutlineInputBorder(),
          isDense: true,
        ),
      );

  // standard border radius
  static final BorderRadius borderRadius = BorderRadius.circular(4.0);
}

class _NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    text = text.replaceAll(RegExp(r"\D"), ""); // remove non digits
    text = (int.tryParse(text) ?? 0).toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
