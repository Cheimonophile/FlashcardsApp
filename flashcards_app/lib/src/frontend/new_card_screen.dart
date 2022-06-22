import 'package:flashcards_app/src/backend/deck_data_access.dart';
import 'package:flashcards_app/src/frontend/dialogs.dart';
import 'package:flashcards_app/src/frontend/visual_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewCardScreen extends StatefulWidget {
  const NewCardScreen(this.deckDao, {super.key});

  final DeckDao deckDao;

  @override
  State<NewCardScreen> createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {
  // state
  int disabled = 0;

  /// function that locks the ui while performing operations
  Future<T> _action<T>(Future<T> Function() f) async {
    setState(() => disabled++);
    return f().catchError((e) {
      Dialogs.alert(context, e.toString());
    }).whenComplete(() {
      setState(() => disabled--);
    });
  }

  @override
  Widget build(BuildContext context) => IgnorePointer(
        ignoring: disabled > 0,
        child: Scaffold(
          appBar: AppBar(title: const Text("New Card")),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // place where card is written
                Expanded(
                  child: Column(
                    children: [
                      const Text("Front"),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: VisUtil.multilineTextField(null),
                        ),
                      ),
                      const Divider(),
                      const Text("Back"),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: VisUtil.multilineTextField(null),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(),
                // place where card is displayed
                Expanded(
                  child: Column(
                    children: [
                      Text("Appearance")
                    ],
                  ),
                ),
              ],
            ),
          )
        ),
      );
}
