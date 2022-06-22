part of flashcards_app.frontend.deck_dashboard;

class _CardsTable extends StatefulWidget {
  const _CardsTable(this.deckDao, this.controller, {super.key});

  final DeckDao deckDao;
  final CardsTableController controller;

  @override
  State<_CardsTable> createState() => _CardsTableState();
}

class _CardsTableState extends State<_CardsTable> {
  // controllers
  final TextEditingController searchController = TextEditingController();

  // constructor constructs
  @override
  void initState() {
    widget.controller._observer = () => setState(() {});
    super.initState();
  }

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
                  child: TextFormField(
                    controller: searchController,
                    decoration: Util.searchDecoration,
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
                  .map((metaCard) => _CardRow(
                        metaCard,
                        widget.controller,
                      ))
                  .toList(),
            ),
          ),
        ],
      );
}

/// a controller for the cards table
class CardsTableController {
  final Set<int> _selected = {};
  Function() _observer = () {};

  /// edit function calls the observer
  T _edit<T>(T Function() f) {
    T result = f();
    _observer();
    return result;
  }

  /// getters
  Set<int> get selected => Set.unmodifiable(_selected);

  /// selected modifiers
  addSelected(Iterable<int> newSelected) =>
      _edit(() => _selected.addAll(newSelected));
  removeSelected(Iterable<int> oldSelected) =>
      _edit(() => _selected.removeAll(oldSelected));
  clearSelected() => _edit(() => _selected.clear());
}
