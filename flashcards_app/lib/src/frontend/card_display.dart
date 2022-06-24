import 'package:flashcards_app/src/frontend/visual_utils.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flashcards_app/src/data/card.dart';

class CardDisplay extends StatelessWidget {
  const CardDisplay(
    this.card, {
    super.key,
    required this.flipDirection,
    required this.flipPosition,
  });

  final Card card;
  final FlipDirection flipDirection;
  final FlipPosition flipPosition;

  @override
  Widget build(BuildContext context) {
    switch (flipDirection) {
      case FlipDirection.front2back:
        switch (flipPosition) {
          case FlipPosition.unflipped:
            return _CardFront2BackUnflipped(card);
          case FlipPosition.flipped:
            return _CardFront2BackUnflipped(card);
        }
      case FlipDirection.back2front:
        switch (flipPosition) {
          case FlipPosition.unflipped:
            return _CardBack2FrontUnflipped(card);
          case FlipPosition.flipped:
            return _CardBack2FrontFlipped(card);
        }
    }
  }
}

class _CardFront2BackUnflipped extends StatelessWidget {
  const _CardFront2BackUnflipped(this.card, {super.key});

  final Card card;

  @override
  Widget build(BuildContext context) => Column(children: [
        Expanded(child: _CardText(card.frontText)),
        const Divider(),
        Expanded(child: _CardText(card.backText))
      ]);
}

class _CardFront2BackFlipped extends StatelessWidget {
  const _CardFront2BackFlipped(this.card, {super.key});

  final Card card;

  @override
  Widget build(BuildContext context) =>
      Column(children: [Expanded(child: _CardText(card.frontText))]);
}

class _CardBack2FrontUnflipped extends StatelessWidget {
  const _CardBack2FrontUnflipped(this.card, {super.key});

  final Card card;

  @override
  Widget build(BuildContext context) => Column(children: [
        Expanded(child: _CardText(card.backText)),
        const Divider(),
        Expanded(child: _CardText(card.frontText))
      ]);
}

class _CardBack2FrontFlipped extends StatelessWidget {
  const _CardBack2FrontFlipped(this.card, {super.key});

  final Card card;

  @override
  Widget build(BuildContext context) =>
      Column(children: [Expanded(child: _CardText(card.backText))]);
}

class _CardText extends StatelessWidget {
  const _CardText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Center(
          child: Text(
        text,
        textAlign: TextAlign.center,
      ));
}

/// the flip direction of the card
enum FlipDirection {
  front2back,
  back2front,
}

/// the flip position of the card
enum FlipPosition {
  unflipped,
  flipped,
}
