library flashcards_app.frontend.nav_bar;

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NavBar extends StatelessWidget {
  NavBar({
    super.key,
    this.currentPageIndex,
    required this.pageNames,
    required this.onPressed,
    this.colors,
  }) {
    if (colors != null) {
      assert(colors!.length == pageNames.length);
    }
  }

  final int? currentPageIndex;
  final List<String> pageNames;
  final List<Color?>? colors;
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) => Row(
        children: pageNames
            .asMap()
            .entries
            .map((entry) => Expanded(
                  child: TextButton(
                    autofocus: false,
                    onPressed: () => onPressed(entry.key),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        entry.value,
                        style: TextStyle(
                          color: entry.key < (colors?.length ?? 0)
                              ? colors![entry.key]
                              : null,
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
            .toList(),
      );
}
