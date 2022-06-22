import 'package:flashcards_app/src/frontend/visual_utils.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flashcards_app/src/data/card.dart';

class CardFront2BackUnflipped extends StatelessWidget {
  const CardFront2BackUnflipped(this.card, {super.key});

  final Card card;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(child: _CardText(card.frontText)),
      const Divider(),
      Expanded(child: _CardText(card.backText))
    ]
  );
}

class CardFront2BackFlipped extends StatelessWidget {
  const CardFront2BackFlipped(this.card, {super.key});

  final Card card;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(child: _CardText(card.frontText))
    ]
  );
}

class CardBack2FrontUnflipped extends StatelessWidget {
  const CardBack2FrontUnflipped(this.card, {super.key});

  final Card card;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(child: _CardText(card.backText)),
      const Divider(),
      Expanded(child: _CardText(card.frontText))
    ]
  );
}

class CardBack2FrontFlipped extends StatelessWidget {
  const CardBack2FrontFlipped(this.card, {super.key});

  final Card card;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(child: _CardText(card.backText))
    ]
  );
}

class _CardText extends StatelessWidget {
  const _CardText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Center(child: Text(text, textAlign: TextAlign.center,));
}