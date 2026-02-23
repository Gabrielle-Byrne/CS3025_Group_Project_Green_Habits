import 'package:flutter/material.dart';
import 'widgets/bottomNavigationBar.dart';
import 'widgets/header.dart';
import 'widgets/theme.dart';


class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class User {
  final String username;
  final int points;

  User(this.username, this.points);
}


class _LeaderboardPageState extends State<LeaderboardPage> {
  LeaderboardScope _scope = LeaderboardScope.faculty;
  ChallengeScope _challengeScope = ChallengeScope.available;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: HeaderBar(
          title: "GREEN HABITS",
          helpText: "Leaderboards and challenges",
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Page title
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
              child: Text(
                "Leaderboards & Challenges",
                style: TextStyle(
                  color: cs.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            // Top tabs: Leaderboard / Challenges
            Container(
              color: AppTheme.navBg,
              child: TabBar(
                labelColor: cs.primary,
                unselectedLabelColor: cs.primary.withOpacity(0.75),
                indicatorColor: cs.primary,
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: "Leaderboard"),
                  Tab(text: "Challenges"),
                ],
              ),
            ),

            // Content
            Expanded(
              child: TabBarView(
                children: [
                  _LeaderboardTab(
                    scope: _scope,
                    onScopeChanged: (s) => setState(() => _scope = s),
                  ),
                  _ChallengesTab(
                    scope: _challengeScope,
                    onScopeChanged: (s) => setState(() => _challengeScope = s),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(currentRoute: "/leaderboard"),
      ),
    );
  }
}

/* ---------------- Leaderboard Tab ---------------- */

enum LeaderboardScope { global, faculty, friends }

class _LeaderboardTab extends StatelessWidget {
  const _LeaderboardTab({
    required this.scope,
    required this.onScopeChanged,
  });

  final LeaderboardScope scope;
  final ValueChanged<LeaderboardScope> onScopeChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Dummy names for UI
    const top1 = "Tom Smith";
    const top2 = "Jane Doe";
    const top3 = "Dan Pearce";

    final contributorsLeft = const [
      "1. Tom Smith",
      "2. Jane Doe",
      "3. Dan Pearce",
      "4. Tracy Kate",
      "5. Jayda Rolle",
    ];

    final contributorsRight = const [
      "6. John Leary",
      "7. John Doe",
      "8. Mason Kay",
      "9. Don Knuth",
      "10. Alan Turing",
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Scope segmented (Global / Faculty / Friends)
          _SegmentedRow<LeaderboardScope>(
            value: scope,
            onChanged: onScopeChanged,
            items: const [
              _SegItem(value: LeaderboardScope.global, label: "Global"),
              _SegItem(value: LeaderboardScope.faculty, label: "Faculty"),
              _SegItem(value: LeaderboardScope.friends, label: "Friends"),
            ],
          ),
          const SizedBox(height: 14),

          Center(
            child: Text(
              "Faculty of Computer Science",
              style: TextStyle(
                color: cs.primary,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Podium (Top 3)
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: _PodiumPerson(
                  name: top2,
                  rank: 2,
                  barHeight: 95,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PodiumPerson(
                  name: top1,
                  rank: 1,
                  barHeight: 130,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PodiumPerson(
                  name: top3,
                  rank: 3,
                  barHeight: 70,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            "Top contributors",
            style: TextStyle(
              color: cs.primary,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),

          // Contributors list box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.navBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _ListColumn(items: contributorsLeft)),
                const SizedBox(width: 12),
                Expanded(child: _ListColumn(items: contributorsRight)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PodiumPerson extends StatelessWidget {
  const _PodiumPerson({
    required this.name,
    required this.rank,
    required this.barHeight,
  });

  final String name;
  final int rank;
  final double barHeight;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: cs.primary,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: barHeight,
          decoration: BoxDecoration(
            color: AppTheme.navBg,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "$rank",
          style: TextStyle(
            color: cs.primary,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _ListColumn extends StatelessWidget {
  const _ListColumn({required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                t,
                style: TextStyle(
                  color: cs.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

/* ---------------- Challenges Tab ---------------- */

enum ChallengeScope { available, achievements }

class _ChallengesTab extends StatelessWidget {
  const _ChallengesTab({
    required this.scope,
    required this.onScopeChanged,
  });

  final ChallengeScope scope;
  final ValueChanged<ChallengeScope> onScopeChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Daily challenge card
          _DailyChallengeCard(
            title: "DAILY CHALLENGE:",
            subtitle: "Use a reusable Mug 2 times today",
            pointsText: "+50 points",
            progress: 0.5,
          ),

          const SizedBox(height: 14),

          // Available / Achievements segmented
          _SegmentedRow<ChallengeScope>(
            value: scope,
            onChanged: onScopeChanged,
            items: const [
              _SegItem(value: ChallengeScope.available, label: "Available"),
              _SegItem(value: ChallengeScope.achievements, label: "Achievements"),
            ],
          ),

          const SizedBox(height: 12),

          // UI-only list
          _ChallengeTile(
            title: "Residence Energy Challenge",
            daysLeftText: "3 days left",
            progress: 0.85,
          ),
          const SizedBox(height: 10),
          _ChallengeTile(
            title: "Meatless Mondays",
            daysLeftText: "7 days left",
            progress: 0.65,
          ),
          const SizedBox(height: 10),
          _ChallengeTile(
            title: "Academic Bike Challenge",
            daysLeftText: "14 days left",
            progress: 0.30,
            showJoin: true,
          ),
        ],
      ),
    );
  }
}

class _DailyChallengeCard extends StatelessWidget {
  const _DailyChallengeCard({
    required this.title,
    required this.subtitle,
    required this.pointsText,
    required this.progress,
  });

  final String title;
  final String subtitle;
  final String pointsText;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: BoxDecoration(
        color: AppTheme.navBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "$title\n$subtitle",
                  style: TextStyle(
                    color: cs.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5,
                    height: 1.15,
                  ),
                ),
              ),
              Text(
                pointsText,
                style: TextStyle(
                  color: cs.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 14,
              backgroundColor: cs.onSurface.withOpacity(0.18),
              valueColor: AlwaysStoppedAnimation(cs.primary),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              "${(progress * 100).round()}% completed",
              style: TextStyle(
                color: cs.primary,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChallengeTile extends StatelessWidget {
  const _ChallengeTile({
    required this.title,
    required this.daysLeftText,
    required this.progress,
    this.showJoin = false,
  });

  final String title;
  final String daysLeftText;
  final double progress;
  final bool showJoin;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: AppTheme.navBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: cs.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                daysLeftText,
                style: TextStyle(
                  color: cs.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 11.5,
                ),
              ),
              if (showJoin) ...[
                const SizedBox(width: 10),
                SizedBox(
                  height: 26,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppTheme.ink,
                        foregroundColor: AppTheme.bg,
                      ),
                    child: const Text("Join"),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: cs.onSurface.withOpacity(0.18),
              valueColor: AlwaysStoppedAnimation(cs.primary),
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------------- Reusable Segmented ---------------- */

class _SegItem<T> {
  const _SegItem({required this.value, required this.label});
  final T value;
  final String label;
}

class _SegmentedRow<T> extends StatelessWidget {
  const _SegmentedRow({
    required this.value,
    required this.onChanged,
    required this.items,
  });

  final T value;
  final ValueChanged<T> onChanged;
  final List<_SegItem<T>> items;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: SegmentedButton<T>(
        showSelectedIcon: false,
        segments: items
            .map(
              (i) => ButtonSegment<T>(
                value: i.value,
                label: Text(i.label),
              ),
            )
            .toList(),
        selected: <T>{value},
        onSelectionChanged: (s) => onChanged(s.first),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return AppTheme.navBg;
            return cs.surfaceVariant;
          }),
          foregroundColor: WidgetStatePropertyAll(cs.primary),
          side: WidgetStatePropertyAll(BorderSide(color: cs.primary, width: 1)),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
        ),
      ),
    );
  }
}

//Future<List<User>> getLeaderboard() async {
//   final db = await database;
//   final List<Map<String, dynamic>> maps = 
//       await db.query('users', orderBy: 'score DESC', limit: 10);
//   return List.generate(maps.length, (i) => User(
//       name: maps[i]['name'], campus: maps[i]['campus'], score: maps[i]['score']));
// }
