import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/challenge_store.dart';
import 'widgets/bottomNavigationBar.dart';
import 'widgets/header.dart';

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
          title: "Leaderboards",
          helpText: "This is the leaderboards and challenges page, where you can view your ranking on the leaderboard and view available challenges to join. You can also view completed challenges through the achievements tab.",
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
                  color: cs.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            // Top tabs: Leaderboard / Challenges
            Container(
              color: cs.secondaryContainer,
              child: TabBar(
                labelColor: cs.onSurface,
                unselectedLabelColor: cs.onSurface.withOpacity(0.75),
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
  const _LeaderboardTab({required this.scope, required this.onScopeChanged});

  final LeaderboardScope scope;
  final ValueChanged<LeaderboardScope> onScopeChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Dummy names for UI (Global)
    const top1 = "Tom Smith (10 800)";
    const top2 = "Jane Doe (10 200)";
    const top3 = "Dan Pearce (9990)";

    final contributorsLeft = const [
      "1. Tom Smith (10 800)",
      "2. Jane Doe (10 200)",
      "3. Dan Pearce (9990)",
      "4. Tracy Kate (9870)",
      "5. Jayda Rolle (9600)",
    ];

    final contributorsRight = const [
      "6. Yohanne Leary (9520)",
      "7. John Doe (9440)",
      "8. Maria Kay (9230)",
      "9. Don Knuth (9010)",
      "10. Alan Turing (8940)",
    ];


     // Dummy names for UI (Faculty)
    const top1Faculty = "Dan Pearce (9990)";
    const top2Faculty = "Maria Kay (9230)";
    const top3Faculty = "Alice Kearley (9000)";

    final contributorsLeftFaculty = const [
      "1. Dan Pearce (9990)",
      "2. Maria Kay (9230)",
      "3. Alice Kearley (9000)",
      "4. James Kearley (8920)",
      "5. Pearl Smith (8780)",
    ];

    final contributorsRightFaculty = const [
      "6. Kevin Reed (8550)",
      "7. Donna Brown (8320)",
      "8. Mason Diamond (7440)",
      "9. Holly Leary (6770)",
      "10. Paulina Green (6500)",
    ];

     // Dummy names for UI (Friends)
    const top1Friends = "Tom Smith (10 800)";
    const top2Friends = "Tracy Kate (9110)";
    const top3Friends = "Monica James (8800)";

    final contributorsLeftFriends = const [
      "1. Tom Smith (10 800)",
      "2. Tracy Kate (9110)",
      "3. Monica James (8800)",
      "4. Krystal Blue (7480)",
      "5. Carl Byrne (7350)",
    ];

    final contributorsRightFriends = const [
      "6. Holly Leary (6770)",
      "7. Paulina Green (6500)",
      "8. Marcel Williams (1220)",
      "9. ",
      "10. ",
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
              scope == LeaderboardScope.friends ? 'Friends' : (scope == LeaderboardScope.faculty ? 'Faculty of Computer Science' : 'Global'),
              style: TextStyle(
                color: cs.onSurface,
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
                child: _PodiumPerson(name: scope == LeaderboardScope.friends ? top2Friends : (scope == LeaderboardScope.faculty ? top2Faculty : top2), rank: 2, barHeight: 95),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PodiumPerson(name: scope == LeaderboardScope.friends ? top1Friends : (scope == LeaderboardScope.faculty ? top1Faculty : top1), rank: 1, barHeight: 130),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PodiumPerson(name: scope == LeaderboardScope.friends ? top3Friends : (scope == LeaderboardScope.faculty ? top3Faculty : top3), rank: 3, barHeight: 70),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            "Top Contributors",
            style: TextStyle(
              color: cs.onSurface,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),

          // Contributors list box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: cs.secondaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _ListColumn(items: scope == LeaderboardScope.friends ? contributorsLeftFriends : (scope == LeaderboardScope.faculty ? contributorsLeftFaculty : contributorsLeft))),
                const SizedBox(width: 12),
                Expanded(child: _ListColumn(items: scope == LeaderboardScope.friends ? contributorsRightFriends : (scope == LeaderboardScope.faculty ? contributorsRightFaculty : contributorsRight))),
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
            color: cs.onSurface,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: barHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: cs.secondaryContainer,
              width: 10.0,
              style: BorderStyle.solid,
            ),
            color: cs.secondaryContainer,
            //rank == 1 ? Color.fromARGB(255, 219, 219, 21) : (rank == 2 ? Color.fromARGB(255, 143, 143, 142) : Color.fromARGB(255, 185, 81, 29)),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "$rank",
          style: TextStyle(
            color: cs.onSurface,
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
                  color: cs.onSurface,
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

class _ChallengesTab extends StatefulWidget {
  const _ChallengesTab({required this.scope, required this.onScopeChanged});

  final ChallengeScope scope;
  final ValueChanged<ChallengeScope> onScopeChanged;

  @override
  State<_ChallengesTab> createState() => _ChallengesTabState();
}

class _ChallengesTabState extends State<_ChallengesTab> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ChallengeStore>().ensureDailyChallenge();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final store = context.watch<ChallengeStore>();
    final daily = store.dailyDef;
    final dailyProgress = store.dailyProgress;
    final dailyPct = (daily == null)
        ? 0.0
        : (dailyProgress / daily.targetCount).clamp(0.0, 1.0);
    final joined = store.joined;
    final available = store.available;
    final achievements = store.achievements;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (daily != null)
            _DailyChallengeCard(
              title: "DAILY CHALLENGE:",
              subtitle: store.dailyDef!.title,
              pointsText: "+${store.dailyDef!.rewardPoints} points",
              progress: dailyPct,
              progressText:
                  "${store.dailyProgress}/${store.dailyDef!.targetCount} completed",
            ),

          const SizedBox(height: 14),

          _SegmentedRow<ChallengeScope>(
            value: widget.scope,
            onChanged: widget.onScopeChanged,
            items: const [
              _SegItem(value: ChallengeScope.available, label: "Available"),
              _SegItem(
                value: ChallengeScope.achievements,
                label: "Achievements",
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (widget.scope == ChallengeScope.available) ...[
            Text(
              "Joined",
              style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),

            if (joined.isEmpty)
              Text(
                "No joined challenges yet.",
                style: TextStyle(color: cs.onSurface),
              ),
            ...joined.map((j) => _JoinedChallengeCard(j)).toList(),

            const SizedBox(height: 14),

            Text(
              "Available",
              style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),

            ...available.map((c) => _AvailableChallengeCard(c)).toList(),
          ] else ...[
            Text(
              "Achievements",
              style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),

            if (achievements.isEmpty)
              Text("No achievements yet.", style: TextStyle(color: cs.onSurface)),
            ...achievements.map((c) => _AchievementCard(c)).toList(),
          ],
        ],
      ),
    );
  }
}

class _JoinedChallengeCard extends StatelessWidget {
  final JoinedChallenge j;
  const _JoinedChallengeCard(this.j);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final pct = (j.progress / j.def.targetCount).clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            j.def.title,
            style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            "${j.def.activityKey}: ${j.progress}/${j.def.targetCount}  •  +${j.def.rewardPoints} pts",
            style: TextStyle(color: cs.onSurface),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: pct,
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

class _AvailableChallengeCard extends StatelessWidget {
  final ChallengeDefinition def;
  const _AvailableChallengeCard(this.def);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${def.title}\n${def.activityKey}: 0/${def.targetCount}  •  +${def.rewardPoints} pts",
              style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 28,
            child: ElevatedButton(
              onPressed: () =>
                  context.read<ChallengeStore>().joinChallenge(def),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
              ),
              child: const Text("Join"),
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final ChallengeDefinition def;
  const _AchievementCard(this.def);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "${def.title}\nCompleted • +${def.rewardPoints} pts",
        style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w800),
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
    required this.progressText,
  });

  final String title;
  final String subtitle;
  final String pointsText;
  final double progress;
  final String progressText;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
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
                    color: cs.onSurface,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5,
                    height: 1.15,
                  ),
                ),
              ),
              Text(
                pointsText,
                style: TextStyle(
                  color: cs.onSurface,
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
              progressText,
              style: TextStyle(
                color: cs.onSurface,
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
        color: cs.secondaryContainer,
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
                    color: cs.onSurface,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                daysLeftText,
                style: TextStyle(
                  color: cs.onSurface,
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
                      backgroundColor: cs.primary,
                      foregroundColor: cs.onPrimary,
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

class ChallengesPanel extends StatelessWidget {
  const ChallengesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<ChallengeStore>();

    return Column(
      children: [
        const SizedBox(height: 10),
        const Text('Available'),
        ...store.available.map(
          (c) => ListTile(
            title: Text(c.title),
            subtitle: Text(
              '${c.activityKey}: 0/${c.targetCount}  •  +${c.rewardPoints} pts',
            ),
            trailing: ElevatedButton(
              onPressed: () => context.read<ChallengeStore>().joinChallenge(c),
              child: const Text('Join'),
            ),
          ),
        ),
        const Divider(),
        const Text('Achievements'),
        ...store.achievements.map(
          (c) => ListTile(
            title: Text(c.title),
            subtitle: Text('Completed • +${c.rewardPoints} pts'),
          ),
        ),
      ],
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
            .map((i) => ButtonSegment<T>(value: i.value, label: Text(i.label)))
            .toList(),
        selected: <T>{value},
        onSelectionChanged: (s) => onChanged(s.first),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return cs.secondary;
            return cs.surfaceVariant;
          }),
          foregroundColor: WidgetStatePropertyAll(cs.onSurface),
          side: WidgetStatePropertyAll(BorderSide(color: cs.onSurface, width: 1)),
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