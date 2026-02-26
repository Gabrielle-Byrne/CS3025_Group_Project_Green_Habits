import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String helpText;
  final bool showBack;
  final String backLabel;

  /// Show a small help icon that opens a dialog using [helpText].
  final bool showHelpButton;

  const HeaderBar({
    super.key,
    required this.title,
    required this.helpText,
    this.showBack = false,
    this.backLabel = "Previous",
    this.showHelpButton = true,
  });

  void _openHelp(BuildContext context) {
    if (helpText.trim().isEmpty) return;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(helpText),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: cs.primary,
      foregroundColor: cs.onPrimary,
      elevation: 0,
      leading: showBack
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: cs.onPrimary, size: 26),
              onPressed: () => Navigator.pop(context),
              tooltip: backLabel,
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.grass, size: 34, color: cs.onPrimary),
            ),
      title: Text(
        showBack ? "$backLabel\n$title" : "GREEN HABITS\n$title",
        style: TextStyle(
          color: cs.onPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
          height: 1.05,
        ),
      ),
      centerTitle: false,
      actions: [
        if (showHelpButton)
          IconButton(
            tooltip: "Help",
            icon: Icon(Icons.help_outline, color: cs.onPrimary),
            onPressed: () => _openHelp(context),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}