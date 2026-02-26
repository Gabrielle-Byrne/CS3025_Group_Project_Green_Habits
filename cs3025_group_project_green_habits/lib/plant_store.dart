import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/points_store.dart';
import 'widgets/header.dart';
import 'state/garden_store.dart';

class PlantStorePage extends StatelessWidget {
  const PlantStorePage({super.key});
  static const String kMysterySeedAsset = 'assets/vectors/planted_seed.svg';

  Future<void> _buy(BuildContext context, String itemName, int cost) async {
    final ok = await context.read<PointsStore>().applyTransaction(
          source: "plant_store",
          amount: -cost,
        );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 650),
          content: Text(
            ok ? "Purchased $itemName (-$cost pts)" : "Not enough points for $itemName",
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: const HeaderBar(
        title: "GREEN HABITS",
        showBack: true,
        backLabel: "Previous",
        helpText: "Use points to buy plants, seed packs, gifts, and power-ups.",
      ),


      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Plant Store",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: ink,
                  ),
                ),
                _PointsDisplay(points: points),
              ],
            ),
            const SizedBox(height: 10),

            // Mystery Seed tile (left aligned)
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 110,
                child: _StoreTile(
                  title: "Mystery Seed",
                  icon: Icon(Icons.water_drop_outlined, size: 30, color: ink),
                  price: 50,
                  onTap: () => _buy(context, "Mystery Seed", 50),
                  bg: cardBg,
                  onTap: () {
                    final pointsStore = context.read<PointsStore>();
                    const price = 50;

                    if (pointsStore.points < price) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Not enough points to buy this."),
                        ),
                      );
                      return;
                    }

                    // Spend points
                    pointsStore.addPoints(-price);

                    // Queue seed to be planted in garden
                    context.read<GardenStore>().queueSeed(kMysterySeedAsset);

                    // Take user to garden to choose plot
                    Navigator.pushReplacementNamed(context, '/garden');

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Seed purchased! Tap a plot to plant it.",
                        ),
                      ),
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
                  onTap: () => _buy(context, "Common Plants", 30),
                ),
                _ChipTile(
                  text: "Rare Flowers",
                  price: 60,
                  onTap: () => _buy(context, "Rare Flowers", 60),
                ),
                const _ChipTile(
                  text: "Elm Tree\nLocked",
                  locked: true,
                ),
              children: [
                _ChipTile(text: "Common Plants", bg: cardBg),
                _ChipTile(text: "Rare Flowers", bg: cardBg),
                _ChipTile(text: "Elm Tree\nLocked", bg: lockedBg, locked: true),
              ],
            ),

            const SizedBox(height: 14),

            const _SectionTitle("Gift a Friend"),
            const SizedBox(height: 8),
            _WideTile(
              title: "Gift a Plant",
              price: 50,
              onTap: () => _buy(context, "Gift a Plant", 50),
            ),
            _WideTile(title: "Gift a Plant", price: 50, bg: cardBg),

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
              children: [
                _StoreTile(
                  title: "Self Watering\nPot",
                  icon: _TripleDropIcon(color: ink),
                  price: 50,
                  onTap: () => _buy(context, "Self Watering Pot", 50),
                  bg: cardBg,
                ),
                _StoreTile(
                  title: "Extend Garden",
                  icon: Icon(Icons.inventory_2_outlined, size: 30, color: ink),
                  price: 100,
                  onTap: () => _buy(context, "Extend Garden", 100),
                  bg: cardBg,
                ),
                _StoreTile(
                  title: "Power Up 3",
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                    color: ink,
                  ),
                  price: 150,
                  onTap: () => _buy(context, "Power Up 3", 150),
                  bg: cardBg,
                ),
                _StoreTile(
                  title: "Power Up 4",
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                    color: ink,
                  ),
                  price: 150,
                  onTap: () => _buy(context, "Power Up 4", 150),
                  bg: cardBg,
                ),
                _StoreTile(
                  title: "Power Up 5",
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                    color: ink,
                  ),
                  price: 150,
                  onTap: () => _buy(context, "Power Up 5", 150),
                  bg: cardBg,
                ),
                const _LockedTile(bg: lockedBg),
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
        color: cs.onSurface,
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
        Icon(Icons.circle, size: 8, color: cs.onSurface),
        const SizedBox(width: 6),
        Text(
          "$points",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: cs.onSurface,
          ),
        ),
      ],
    );
  }
}

class _ChipTile extends StatelessWidget {
  const _ChipTile({
    required this.text,
    required this.bg, this.locked = false,
    this.price,
    this.onTap,
  });

  final String text;
  final Color bg;
  final bool locked;
  final int? price;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
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
                  color: cs.onSurface,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
              if (price != null && !locked) ...[
                const SizedBox(height: 6),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.circle, size: 7, color: kDarkGreen),
                    SizedBox(width: 5),
                  ],
                ),
                Text(
                  "$price",
                  style: const TextStyle(
                    color: kDarkGreen,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    height: 1.0,
                  ),
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
    this.onTap,
  , required this.bg});

  final String title;
  final int price;
  final VoidCallback? onTap;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
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
                  color: cs.onSurface,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.circle, size: 8, color: cs.onSurface),
                  const SizedBox(width: 6),
                  Text(
                    "$price",
                    style: TextStyle(
                      color: cs.onSurface,
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
    this.onTap,
    required this.bg,
    this.onTap,
  });

  final String title;
  final Widget icon;
  final int price;
  final VoidCallback? onTap;
  final Color bg;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kCard,
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
                style: const TextStyle(
                  color: kDarkGreen,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
              icon,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.circle, size: 8, color: kDarkGreen),
                  const SizedBox(width: 6),
                  Text(
                    "$price",
                    style: const TextStyle(
                      color: kDarkGreen,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    final cs = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Ink(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: cs.onSurface,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              icon,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle, size: 8, color: cs.onSurface),
                  const SizedBox(width: 6),
                  Text(
                    "$price",
                    style: TextStyle(
                      color: cs.onSurface,
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
  const _LockedTile({required this.bg});
  final Color bg;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline, size: 28, color: cs.onSurface),
          const SizedBox(height: 8),
          const SizedBox(height: 2),
          Expanded(
            child: Center(
              child: Text(
                "Locked\nComplete\nChallenge to\nUnlock Power-\nUp",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: cs.onSurface,
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
