import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/header.dart';
import 'state/points_store.dart';
import 'widgets/bottomNavigationBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int kNextRewardGoal = 200; // prototype milestone

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final panelFill = cs.surfaceVariant;
    final panelBorder = isDark
        ? cs.outlineVariant.withOpacity(0.65)
        : cs.outlineVariant.withOpacity(0.45);
    final titleColor = cs.onSurface;

    final pillBg = cs.primaryContainer;
    final pillFg = cs.onPrimaryContainer;
    final points = context.watch<PointsStore>().points;
    final remaining = (kNextRewardGoal - points).clamp(0, kNextRewardGoal);
    final progress = (points / kNextRewardGoal).clamp(0.0, 1.0);

    final progressBg = cs.onSurface.withOpacity(0.18);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const HeaderBar(
        title: "Home",
        helpText:
            "This is the home screen. Log sustainable actions to earn points, then spend them in the Virtual Garden.",
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Virtual Garden",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/garden'),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: panelFill,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: panelBorder, width: 1),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "Quick-Log Action Bar",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 8),

            Row(
              children: const [
                Expanded(child: _QuickAction(label: "Quick Action\n1")),
                Expanded(child: _QuickAction(label: "Quick Action\n2")),
                Expanded(child: _QuickAction(label: "Quick Action\n3")),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "Community",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: titleColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Rewards",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: titleColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            SizedBox(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: panelFill,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: panelBorder, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/leaderboard'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: pillBg,
                                foregroundColor: pillFg,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text(
                                "Leaderboard",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "1.  Tom Smith\n2.  Jane Doe\n3.  Dan Pearce",
                            style: TextStyle(
                              color: titleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: panelFill,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: panelBorder, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: SizedBox(
                              height: 14,
                              width: double.infinity,
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: progressBg,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  cs.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              "$remaining points left to collect\nthis reward",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: titleColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 1.2,
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 34,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: cs.primary,
                                foregroundColor: cs.onPrimary,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text(
                                "View Past Actions",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const BottomNavigation(currentRoute: "/home"),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String label;
  const _QuickAction({required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final circleFill = cs.surfaceVariant;

    return Column(
      children: [
        Container(
          width: 74,
          height: 74,
          decoration: BoxDecoration(color: circleFill, shape: BoxShape.circle),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: cs.onSurface,
            fontWeight: FontWeight.w700,
            fontSize: 11,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}
