import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/points_store.dart';
import 'widgets/bottomNavigationBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Brand colors for the top header/tips button (matches your mock)
  static const Color kDarkGreen = Color(0xFF084E18);
  static const Color kTipGreen = Color(0xFF1E6B2A);

  // Light-mode panel styling (dark mode uses theme containers)
  static const Color kPanelFill = Color(0xFFD6E4D6);
  static const Color kPanelBorder = Color(0xFFB8C8B8);
  static const Color kNavSelectedPill = Color(0xFFB8C8B8);

  static const int kNextRewardGoal = 200; // prototype milestone

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final panelFill = isDark ? cs.secondaryContainer : kPanelFill;
    final panelBorder = isDark ? cs.outline.withOpacity(0.6) : kPanelBorder;
    final titleColor = cs.onSurface; // ✅ mint in dark mode

    final pillBg = isDark ? cs.primary.withOpacity(0.22) : kNavSelectedPill;
    final pillFg = titleColor;

    final points = context.watch<PointsStore>().points;
    final remaining = (kNextRewardGoal - points).clamp(0, kNextRewardGoal);
    final progress = (points / kNextRewardGoal).clamp(0.0, 1.0);

    final progressBg = isDark ? titleColor.withOpacity(0.15) : const Color(0xFFCFE0CF);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: SafeArea(
          bottom: false,
          child: Container(
            height: 56,
            color: kDarkGreen,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(Icons.park, color: cs.onPrimary, size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "GREEN HABITS",
                    style: TextStyle(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                SizedBox(
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/tips'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kTipGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Need\nTips?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        height: 1.05,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
                      padding: const EdgeInsets.all(10),
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
                      padding: const EdgeInsets.all(10),
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
                                valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
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
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/history'),
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

  static const Color kCircleFillLight = Color(0xFFCFE0CF);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final circleFill = isDark ? cs.secondaryContainer : kCircleFillLight;

    return Column(
      children: [
        Container(
          width: 74,
          height: 74,
          decoration: BoxDecoration(
            color: circleFill,
            shape: BoxShape.circle,
          ),
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
