import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/challenge_store.dart';

class ChallengeSnackBarListener extends StatefulWidget {
  final Widget child;
  const ChallengeSnackBarListener({super.key, required this.child});

  @override
  State<ChallengeSnackBarListener> createState() => _ChallengeSnackBarListenerState();
}

class _ChallengeSnackBarListenerState extends State<ChallengeSnackBarListener> {
  int _lastSeenTick = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final store = context.watch<ChallengeStore>();
    final tick = store.completionTick;

    if (tick == _lastSeenTick) return;
    _lastSeenTick = tick;

    final msg = store.lastCompletionMessage;
    if (msg == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text(msg),
          duration: const Duration(milliseconds: 700),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}