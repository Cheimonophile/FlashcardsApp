part of flashcards_app.frontend.deck_dashboard;

class _CardsTable extends StatefulWidget {
  const _CardsTable(this.deckDao, {super.key});

  final DeckDao deckDao;

  @override
  State<_CardsTable> createState() => _CardsTableState();
}

class _CardsTableState extends State<_CardsTable> {
  // controllers
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      // search parameters
      Row(
        children: [
          // search bar
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: VisUtil.searchDecoration,
              ),
            ),
          ),
        ],
      ),
      // cards table
      const Divider(),
      Expanded(
        child: ListView(
          children: widget.deckDao
              .cards()
              .map((metaCard) => TextButton(
                    onPressed: () {},
                    child: Text(metaCard.card.frontText),
                  ))
              .toList(),
        ),
      ),
    ],
  );
}
