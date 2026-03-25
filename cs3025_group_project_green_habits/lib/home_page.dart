import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'state/activity_log_store.dart';
import 'state/garden_store.dart';
import 'state/points_store.dart';
import 'widgets/bottomNavigationBar.dart';
import 'widgets/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int kNextRewardGoal = 200;
  static const List<String> _availableActivities = [
    'Recycling',
    'Transit',
    'Energy',
  ];

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

    final garden = context.watch<GardenStore>();
    final activityLog = context.watch<ActivityLogStore>();
    final quickActions = _rankQuickActions(activityLog);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const HeaderBar(
        title: 'Home',
        helpText:
            'This is the home screen where you can see an overview of your virtual garden, quickly log new activities, and access community features.',
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Virtual Garden',
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
                  padding: const EdgeInsets.all(12),
                  child: _GardenOverview(
                    garden: garden,
                    titleColor: titleColor,
                    panelBorder: panelBorder,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Quick-Log Action Bar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: quickActions
                  .map(
                    (action) => Expanded(
                      child: _QuickAction(
                        label: action.label,
                        icon: action.icon,
                        count: action.count,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/activity-log',
                            arguments: action.label,
                          );
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Community',
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
                      'Rewards',
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
                                'Leaderboard',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '1.  Tom Smith\n2.  Jane Doe\n3.  Dan Pearce',
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
                              '$remaining points left to collect\nthis reward',
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
                                  (),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: cs.primary,
                                foregroundColor: cs.onPrimary,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text(
                                'View Past Actions',
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
      bottomNavigationBar: const BottomNavigation(currentRoute: '/home'),
    );
  }

  List<_QuickActionData> _rankQuickActions(ActivityLogStore store) {
    final counts = <String, int>{
      for (final activity in _availableActivities) activity: 0,
    };

    final lastSeenIndex = <String, int>{
      for (final activity in _availableActivities) activity: 1 << 30,
    };

    for (var i = 0; i < store.entries.length; i++) {
      final type = store.entries[i].activityType;
      if (!counts.containsKey(type)) continue;

      counts[type] = counts[type]! + 1;
      lastSeenIndex[type] = i;
    }

    final sorted = _availableActivities.toList()
      ..sort((a, b) {
        final countCompare = counts[b]!.compareTo(counts[a]!);
        if (countCompare != 0) return countCompare;

        final recencyCompare = lastSeenIndex[a]!.compareTo(lastSeenIndex[b]!);
        if (recencyCompare != 0) return recencyCompare;

        return _availableActivities
            .indexOf(a)
            .compareTo(_availableActivities.indexOf(b));
      });

    return sorted
        .map(
          (activity) => _QuickActionData(
            label: activity,
            count: counts[activity]!,
            icon: _iconForActivity(activity),
          ),
        )
        .toList();
  }

  IconData _iconForActivity(String activity) {
    switch (activity) {
      case 'Recycling':
        return Icons.recycling;
      case 'Transit':
        return Icons.directions_bus;
      case 'Energy':
        return Icons.bolt;
      default:
        return Icons.eco;
    }
  }
}

class _GardenOverview extends StatelessWidget {
  const _GardenOverview({
    required this.garden,
    required this.titleColor,
    required this.panelBorder,
  });
  

  final GardenStore garden;
  final Color titleColor;
  final Color panelBorder;
  
  

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final plantedCount = List.generate(
      garden.plotCount,
      (index) => garden.plotAt(index),
    ).whereType<PlantedItem>().length;
    final previewCount = garden.plotCount >= 12 ? 12 : garden.plotCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '$plantedCount/${garden.plotCount} plots planted',
                style: TextStyle(
                  color: titleColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
            Text(
              garden.pendingSeeds == 1
                  ? '1 seed waiting'
                  : '${garden.pendingSeeds} seeds waiting',
              style: TextStyle(
                color: cs.primary,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: previewCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: garden.cols,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final planted = garden.plotAt(index);

              return Container(
                decoration: BoxDecoration(
                  color: cs.surface.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: panelBorder, width: 1),
                ),
                child: Center(
                  child: planted == null
                      ? Icon(
                          Icons.add,
                          size: 18,
                          color: cs.onSurface.withOpacity(0.25),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8),
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            heightFactor: 0.9,
                            child: SvgPicture.asset(
                              planted.assetPath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            'Tap to open full garden',
            style: TextStyle(
              color: cs.onSurface.withOpacity(0.7),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// class _QuickAction extends StatelessWidget {
//   const _QuickAction({
//     required this.label,
//     required this.icon,
//     required this.count,
//     required this.onTap,
//   });

//   final String label;
//   final IconData icon;
//   final int count;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final circleFill = cs.surfaceVariant;

//     return Column(
//       children: [
//         Material(
//           color: Colors.transparent,
//           child: InkWell(
//             onTap: onTap,
//             borderRadius: BorderRadius.circular(50),
//             child: Container(
//               width: 74,
//               height: 74,
//               decoration: BoxDecoration(
//                 color: circleFill,
//                 shape: BoxShape.circle,
//               ),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Icon(icon, color: cs.primary, size: 30),
//                   if (count > 0)
//                     Positioned(
//                       right: 6,
//                       top: 6,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 6,
//                           vertical: 2,
//                         ),
//                         decoration: BoxDecoration(
//                           color: cs.primary,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           '$count',
//                           style: TextStyle(
//                             color: cs.onPrimary,
//                             fontSize: 10,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           label,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: cs.onSurface,
//             fontWeight: FontWeight.w700,
//             fontSize: 11,
//             height: 1.1,
//           ),
//         ),
//       ],
//     );
//   }
// }
class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.label,
    required this.icon,
    required this.count,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final circleFill = cs.surfaceVariant;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 74,
              height: 74,
              decoration: BoxDecoration(
                color: circleFill,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: cs.primary,
                  size: 30,
                ),
              ),
            ),
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

class _QuickActionData {
  const _QuickActionData({
    required this.label,
    required this.icon,
    required this.count,
  });

  final String label;
  final IconData icon;
  final int count;
}
