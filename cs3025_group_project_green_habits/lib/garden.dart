import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/header.dart';
import 'widgets/bottomNavigationBar.dart';
import 'state/garden_store.dart';

class GardenPage extends StatefulWidget {
  const GardenPage({super.key});
  @override
  State<GardenPage> createState() => _GardenPageState();
}

class _GardenPageState extends State<GardenPage> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final panelFill = cs.surfaceVariant;
    final panelBorder = isDark
        ? cs.outlineVariant.withOpacity(0.65)
        : cs.outlineVariant.withOpacity(0.45);

    final garden = context.watch<GardenStore>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const HeaderBar(
        title: "Virtual Garden",
        helpText:
            "This is your garden. You can use points earned from your actions to purchase virtual plants.",
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
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 8),

            // Small helper line
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                garden.pendingSeeds > 0
                    ? "Seeds to plant: ${garden.pendingSeeds} (tap an empty plot)"
                    : "Buy a Mystery Seed, then tap a plot to plant it.",
                style: TextStyle(
                  color: cs.onSurface.withOpacity(0.85),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: panelFill,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: panelBorder, width: 1),
                ),
                padding: const EdgeInsets.all(12),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // For 12 plots, this looks best as 4 columns on most phones.
                    final crossAxisCount = constraints.maxWidth < 360 ? 3 : 4;

                    return GridView.builder(
                      itemCount: garden.plotCount,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, i) {
                        final planted = garden.plotAt(i);
                        final hasSeedToPlant = garden.pendingSeeds > 0;

                        return _PlotTile(
                          planted: planted,
                          highlightEmpty: hasSeedToPlant && planted == null,
                          onTap: () async {
                            if (planted != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "This plot already has something planted.",
                                  ),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              return;
                            }

                            if (!hasSeedToPlant) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "No seeds to plant. Buy one in Plant Store.",
                                  ),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              return;
                            }

                            // Confirm plant
                            final ok = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Plant seed here?"),
                                content: const Text(
                                  "This will plant your next seed in this plot.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text("Plant"),
                                  ),
                                ],
                              ),
                            );

                            if (ok == true) {
                              final plantedOk = context
                                  .read<GardenStore>()
                                  .plantNextSeedAt(i);
                              if (!plantedOk && mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Could not plant here."),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/plant_store'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: cs.primary,
                  foregroundColor: cs.onPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  "Plant Store",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentRoute: "/garden"),
    );
  }
}

class _PlotTile extends StatelessWidget {
  const _PlotTile({
    required this.planted,
    required this.onTap,
    required this.highlightEmpty,
  });

  final PlantedItem? planted;
  final VoidCallback onTap;
  final bool highlightEmpty;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final soil = cs.surface.withOpacity(0.35);
    final border = highlightEmpty ? cs.primary : cs.outlineVariant.withOpacity(0.45);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          decoration: BoxDecoration(
            color: soil,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: border, width: highlightEmpty ? 2 : 1),
          ),
          child: Center(
            child: planted == null
                ? Icon(
                    Icons.add,
                    size: 28,
                    color: highlightEmpty
                        ? cs.primary
                        : cs.onSurface.withOpacity(0.35),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8),
                    child: FractionallySizedBox(
                      widthFactor: 0.75,
                      heightFactor: 0.75,
                      child: SvgPicture.asset(
                        planted!.assetPath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
