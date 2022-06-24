library flashcards_app.frontend.nav_bar;

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NavBar extends StatelessWidget {
  const NavBar(
      {Key? key,
      required this.currentPageIndex,
      required this.pageNames,
      required this.onPressed})
      : super(key: key);

  final int currentPageIndex;
  final List<String> pageNames;
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) => Row(
      children: pageNames
          .asMap()
          .entries
          .map((entry) => Expanded(
                child: TextButton(
                  autofocus: true,
                  onPressed: () => onPressed(entry.key),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleLarge?.fontSize,
                        decoration: entry.key == currentPageIndex
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ))
          .toList());
}
