


part of flashcards_app.frontend.deck_dashboard;

class _CardsTable extends StatefulWidget {
  const _CardsTable(this.deckDao, {super.key});

  final DeckDao deckDao;

  @override
  State<_CardsTable> createState() => _CardsTableState();
}

class _CardsTableState extends State<_CardsTable> {
  @override
  Widget build(BuildContext context) => Container(
    child: Row()
  );
}