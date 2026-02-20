import 'package:flutter/material.dart';
import 'theme.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String helpText;

  const HeaderBar({
    Key? key,
    required this.title,
    required this.helpText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          Icons.grass,
          size: 48,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      title: Text("Green Habits\n$title"),
      centerTitle: false,
      actions: <Widget>[
          IconButton(icon: Icon(Icons.question_mark_outlined, size: 48, color: Theme.of(context).colorScheme.onPrimary), onPressed: () {}),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}