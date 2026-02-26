import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/header.dart';
import 'state/points_store.dart';
import 'state/garden_store.dart';

class PlantStorePage extends StatelessWidget {
  const PlantStorePage({super.key});

  static const String kMysterySeedAsset = 'assets/vectors/planted_seed.svg';

  Future<void> _purchase(
    BuildContext context, {
    required String itemName,
    required int cost,
    VoidCallback? afterSuccess,
  }) async {
    final ok = await context.read<PointsStore>().applyTransaction(
          source: "plant_store",
          amount: -cost,
        );

    if (!context.mounted) return;

    if (!ok) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 650),
            content: Text("Not enough points for $itemName"),
          ),
        );
      return;
    }

    afterSuccess?.call();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 650),
          content: Text("Purchased $itemName (-$cost pts)"),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final points = context.watch<PointsStore>().points;
    final cs = Theme.of(context).colorScheme;

    final cardBg = cs.surfaceVariant;
    final lockedBg = cs.surfaceVariant.withOpacity(0.6);
    final fg = cs.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const HeaderBar(
        title: "Plant Store",
        showBack: true,
        backLabel: "Previous",
        helpText: "Use points to buy plants, seed packs, gifts, and power-ups.",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Plant Store",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: fg,
                  ),
                ),
                _PointsDisplay(points: points),
              ],
            ),
            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 120,
                child: _StoreTile(
                  title: "Mystery Seed",
                  icon: Icon(Icons.water_drop_outlined, size: 30, color: fg),
                  price: 50,
                  bg: cardBg,
                  fg: fg,
                  onTap: () async {
                    await _purchase(
                      context,
                      itemName: "Mystery Seed",
                      cost: 50,
                      afterSuccess: () {
                        context.read<GardenStore>().queueSeed(kMysterySeedAsset);
                        Navigator.pushReplacementNamed(context, '/garden');

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 750),
                              content: Text("Seed purchased! Tap a plot to plant it."),
                            ),
                          );
                      },
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 14),

            const _SectionTitle("Seed Packs"),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _ChipTile(
                  text: "Common Plants",
                  price: 30,
                  bg: Theme.of(context).colorScheme.secondaryContainer,
                  fg: fg,
                  onTap: () => _purchase(context, itemName: "Common Plants", cost: 30),
                ),
                _ChipTile(
                  text: "Rare Flowers",
                  price: 60,
                  bg: Theme.of(context).colorScheme.secondaryContainer,
                  fg: fg,
                  onTap: () => _purchase(context, itemName: "Rare Flowers", cost: 60),
                ),
                _ChipTile(
                  text: "Elm Tree\nLocked",
                  locked: true,
                  bg: lockedBg,
                  fg: fg,
                ),
              ],
            ),

            const SizedBox(height: 14),

            const _SectionTitle("Gift a Friend"),
            const SizedBox(height: 8),
            _WideTile(
              title: "Gift a Plant",
              price: 50,
              bg: cardBg,
              fg: fg,
              onTap: () => _purchase(context, itemName: "Gift a Plant", cost: 50),
            ),

            const SizedBox(height: 14),

            const _SectionTitle("Power-Ups"),
            const SizedBox(height: 8),

            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.95,
              children: [
                _StoreTile(
                  title: "Self Watering\nPot",
                  icon: _TripleDropIcon(color: fg),
                  price: 50,
                  bg: cardBg,
                  fg: fg,
                  onTap: () => _purchase(context, itemName: "Self Watering Pot", cost: 50),
                ),
                _StoreTile(
                  title: "Extend Garden",
                  icon: Icon(Icons.inventory_2_outlined, size: 30, color: fg),
                  price: 100,
                  bg: cardBg,
                  fg: fg,
                  onTap: () => _purchase(context, itemName: "Extend Garden", cost: 100),
                ),
                _StoreTile(
                  title: "Power Up 3",
                  icon: Icon(Icons.shopping_cart_outlined, size: 30, color: fg),
                  price: 150,
                  bg: cardBg,
                  fg: fg,
                  onTap: () => _purchase(context, itemName: "Power Up 3", cost: 150),
                ),
                _StoreTile(
                  title: "Power Up 4",
                  icon: Icon(Icons.shopping_cart_outlined, size: 30, color: fg),
                  price: 150,
                  bg: cardBg,
                  fg: fg,
                  onTap: () => _purchase(context, itemName: "Power Up 4", cost: 150),
                ),
                _StoreTile(
                  title: "Power Up 5",
                  icon: Icon(Icons.shopping_cart_outlined, size: 30, color: fg),
                  price: 150,
                  bg: cardBg,
                  fg: fg,
                  onTap: () => _purchase(context, itemName: "Power Up 5", cost: 150),
                ),
                _LockedTile(bg: lockedBg, fg: fg),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------- Small UI widgets ---------- */

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w800,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class _PointsDisplay extends StatelessWidget {
  const _PointsDisplay({required this.points});
  final int points;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(Icons.circle, size: 8, color: cs.primary),
        const SizedBox(width: 6),
        Text(
          "$points",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: cs.primary,
          ),
        ),
      ],
    );
  }
}

class _ChipTile extends StatelessWidget {
  const _ChipTile({
    required this.text,
    required this.bg,
    required this.fg,
    this.locked = false,
    this.price,
    this.onTap,
  });

  final String text;
  final Color bg;
  final Color fg;
  final bool locked;
  final int? price;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = !locked && onTap != null;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: fg,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
              if (!locked && price != null) ...[
                const SizedBox(height: 6),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, size: 7, color: fg),
                    const SizedBox(width: 5),
                    Text(
                      "$price",
                      style: TextStyle(
                        color: fg,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _WideTile extends StatelessWidget {
  const _WideTile({
    required this.title,
    required this.price,
    required this.bg,
    required this.fg,
    this.onTap,
  });

  final String title;
  final int price;
  final Color bg;
  final Color fg;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: fg,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.circle, size: 8, color: fg),
                  const SizedBox(width: 6),
                  Text(
                    "$price",
                    style: TextStyle(
                      color: fg,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoreTile extends StatelessWidget {
  const _StoreTile({
    required this.title,
    required this.icon,
    required this.price,
    required this.bg,
    required this.fg,
    this.onTap,
  });

  final String title;
  final Widget icon;
  final int price;
  final Color bg;
  final Color fg;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: fg,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
              icon,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle, size: 8, color: fg),
                  const SizedBox(width: 6),
                  Text(
                    "$price",
                    style: TextStyle(
                      color: fg,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LockedTile extends StatelessWidget {
  const _LockedTile({required this.bg, required this.fg});
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline, size: 28, color: fg),
          const SizedBox(height: 8),
          Expanded(
            child: Center(
              child: Text(
                "Locked\nComplete\nChallenge to\nUnlock Power-\nUp",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: fg,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TripleDropIcon extends StatelessWidget {
  const _TripleDropIcon({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.water_drop_outlined, size: 18, color: color),
        const SizedBox(width: 4),
        Icon(Icons.water_drop_outlined, size: 18, color: color),
        const SizedBox(width: 4),
        Icon(Icons.water_drop_outlined, size: 18, color: color),
      ],
    );
  }
}