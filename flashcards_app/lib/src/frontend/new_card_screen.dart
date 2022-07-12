import 'package:flashcards_app/src/algorithms/pick_cards.dart';
import 'package:flashcards_app/src/backend/deck_data_access.dart';
import 'package:flashcards_app/src/data/card.dart';
import 'package:flashcards_app/src/frontend/card_display.dart';
import 'package:flashcards_app/src/frontend/dialogs.dart';
import 'package:flashcards_app/src/frontend/screen.dart';
import 'package:flashcards_app/src/frontend/visual_utils.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewCardScreen extends Screen {
  const NewCardScreen(this.deckDao, {super.key});

  final DeckDao deckDao;

  @override
  ScreenState<NewCardScreen, dynamic> createState() => _NewCardScreenState();
}

class _NewCardScreenState extends ScreenState<NewCardScreen, dynamic> {

  // controllers
  final TextEditingController frontTextController = TextEditingController();
  final TextEditingController backTextController = TextEditingController();

  @override
  late final Map<SingleActivator, Function()> shortcuts = {
    const SingleActivator(LogicalKeyboardKey.keyS, control: true): _save, // windows
    const SingleActivator(LogicalKeyboardKey.keyS, meta: true): _save, // mac
  };

  /// contructor does construction
  _NewCardScreenState() {
    frontTextController.addListener(() => setState(() {}));
    backTextController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    frontTextController.dispose();
    backTextController.dispose();
    super.dispose();
  }

  /// generates the card
  Card get card => Card(
        frontText: frontTextController.text.trim(),
        backText: backTextController.text.trim(),
      );

  /// saves the card
  _save() {
    widget.deckDao.addCards([card]);
    frontTextController.clear();
    backTextController.clear();
  }

  @override
  Scaffold buildScreen(BuildContext context) => Scaffold(
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
                        child: Util.multilineTextField(frontTextController),
                      ),
                    ),
                    const Divider(),
                    const Text("Back"),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Util.multilineTextField(backTextController),
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalDivider(),
              // place where card is displayed
              Expanded(
                child: CardDisplay(
                  card,
                  flipDirection: FlipDirection.front2back,
                  flipPosition: FlipPosition.flipped,
                ),
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          OutlinedButton(
            onPressed: _save,
            child: const Text("Save"),
          )
        ],
      );
}
