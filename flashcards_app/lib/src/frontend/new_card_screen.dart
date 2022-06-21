



import 'package:flashcards_app/src/backend/deck_data_access.dart';
import 'package:flashcards_app/src/frontend/dialogs.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

// class NewCardScreen extends StatefulWidget {
//   const NewCardScreen(this.deckDao, {super.key});

//   final DeckDao deckDao;

//   @override
//   State <NewCardScreen> createState() =>  _NewCardScreenState();
// }

// class  _NewCardScreenState extends State <NewCardScreen> {
//   // state
//   int disabled = 0;


//   /// function that locks the ui while performing operations
//   Future<T> _action<T>(Future<T> Function() f) async {
//     setState(() => disabled++);
//     return f().catchError((e) {
//       Dialogs.alert(context, e.toString());
//     }).whenComplete(() {
//       setState(() => disabled--);
//     });
//   }


//   @override
//   Widget build(BuildContext context) {
    
//   }
// }