import 'package:flashcards_app/app.dart';
import 'package:flashcards_app/src/algorithms/pick_cards.dart';
import 'package:flashcards_app/src/algorithms/process_review.dart';
import 'package:flashcards_app/src/backend/deck_data_access.dart';
import 'package:flashcards_app/src/data/card.dart';
import 'package:flashcards_app/src/frontend/card_display.dart';
import 'package:flashcards_app/src/frontend/dialogs.dart';
import 'package:flashcards_app/src/frontend/nav_bar.dart';
import 'package:flashcards_app/src/frontend/score_extension.dart';
import 'package:flashcards_app/src/frontend/screen.dart';
import 'package:flashcards_app/src/frontend/visual_utils.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends Screen<List<MetaCard>> {
  final List<ReviewCard> reviewCards;
  final ProcessReviewAlgo algo;

  /// constructor constructs
  const ReviewScreen(this.reviewCards, {super.key, required this.algo});

  @override
  createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ScreenState<ReviewScreen, List<MetaCard>> {
  // view state fields
  FlipPosition flipPosition = FlipPosition.unflipped;

  // review fields
  final List<ReviewCard> done = [];
  final List<ReviewCard> notDone = [];

  @override
  void initState() {
    // add all cards to the list
    notDone.addAll(widget.reviewCards);
    notDone.shuffle();
    super.initState();
  }

  /// makes all modifications to the cards and returns them with pop
  Future _backToDashboard() => lock(() async {
        // make sure the user is finished reviewing
        if (notDone.isEmpty) {
          popRoute(
            done.map((reviewCard) => reviewCard.metaCard).toList(),
          );
          return;
        }
        // if not done, ask for permission
        bool hasPermission = await Dialogs.permission(
              "Are you sure you want to quit reviewing?\nYou haven't seen all of the cards yet.\n(Your progress will not be saved)",
            ) ??
            false;
        if (hasPermission) {
          popRoute();
        }
      });

  /// flips the current card
  _flip() => lock(() async {
        flipPosition = FlipPosition.flipped;
      });

  /// judges the card and moves to the next
  _judge(bool gotCorrect) => lock(() async {
        notDone[0].timesSeen++;
        if (gotCorrect) {
          widget.algo.process(notDone[0]);
          done.add(notDone[0]);
        } else {
          notDone.add(notDone[0]);
        }
        notDone.removeAt(0);
        flipPosition = FlipPosition.unflipped;
      });

  /// Respond to button presses
  _bottomButtonPressed(int buttonIndex) =>
      bottomButtons[buttonIndex].onPressed();

  /// lists of buttons
  late final List<_BottomButton> _unflippedButtons = [
    _BottomButton("Flip", _flip),
  ];
  late final List<_BottomButton> _flippedButtons = [
    _BottomButton("Incorrect", () => _judge(false), color: Colors.red),
    _BottomButton("Correct", () => _judge(true), color: Colors.green),
  ];
  late final List<_BottomButton> _doneButtons = [
    _BottomButton("Back to Dashboard", _backToDashboard),
  ];

  /// gets the bottom buttons for the card given its state
  List<_BottomButton> get bottomButtons => notDone.isEmpty
      ? _doneButtons
      : flipPosition == FlipPosition.unflipped
          ? _unflippedButtons
          : _flippedButtons;

  @override
  Scaffold buildScreen(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: _backToDashboard,
          ), // TextButton(onPressed: back, child: Text("back")),
          automaticallyImplyLeading: false,
          title: const Text("Review"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IntrinsicHeight(child: _ReviewProgressBar(done, notDone)),
              Expanded(
                child: notDone.isEmpty
                    ? const Center(child: Text("Done!"))
                    : CardDisplay(
                        notDone[0].metaCard.card,
                        flipDirection: notDone[0].flipDirection,
                        flipPosition: flipPosition,
                      ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: NavBar(
            pageNames: bottomButtons.map((button) => button.text).toList(),
            colors: bottomButtons.map((button) => button.color).toList(),
            onPressed: _bottomButtonPressed,
          ),
        ),
      );
}

class _BottomButton {
  final String text;
  final Function() onPressed;
  final Color? color;
  _BottomButton(this.text, this.onPressed, {this.color});
}

class _ReviewProgressBar extends StatelessWidget {
  final List<ReviewCard> done;
  final List<ReviewCard> notDone;
  _ReviewProgressBar(this.done, this.notDone, {super.key}) {
    done.sort((a, b) => a.score < b.score ? -1 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: Util.borderRadius,
      child: Container(
        constraints: const BoxConstraints(minHeight: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: done
                  .map((reviewCard) => Expanded(
                      child: ColoredBox(color: reviewCard.score.color)))
                  .toList() +
              notDone
                  .map((reviewCard) => const Expanded(
                        child: ColoredBox(color: Colors.grey),
                      ))
                  .toList(),
        ),
      ),
    );
  }
}