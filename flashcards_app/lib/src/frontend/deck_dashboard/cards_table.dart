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

  // constructor does setup
  _CardsTableState() {
    widget.deckDao.addCallback(() => setState((){}));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        child: Column(
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
                      decoration: VisUtil.inputDecoration,
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
        ),
      );
}
