import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/points_store.dart';
import 'widgets/header.dart';
import 'state/garden_store.dart';

class PlantStorePage extends StatelessWidget {
  const PlantStorePage({super.key});
  static const String kMysterySeedAsset = 'assets/vectors/planted_seed.svg';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = cs.secondaryContainer;
    final lockedBg = isDark
        ? cs.primary.withOpacity(0.28)
        : const Color(0xFF85A98D);
    final ink = cs.onSurface; // ✅ mint in dark mode

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
                _PointsDisplay(points: context.watch<PointsStore>().points),
              ],
            ),
            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 110,
                child: _StoreTile(
                  title: "Mystery Seed",
                  icon: Icon(Icons.water_drop_outlined, size: 30, color: ink),
                  price: 50,
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
                _ChipTile(text: "Common Plants", bg: cardBg),
                _ChipTile(text: "Rare Flowers", bg: cardBg),
                _ChipTile(text: "Elm Tree\nLocked", bg: lockedBg, locked: true),
              ],
            ),

            const SizedBox(height: 14),

            const _SectionTitle("Gift a Friend"),
            const SizedBox(height: 8),
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
                _StoreTile(
                  title: "Self Watering\nPot",
                  icon: _TripleDropIcon(color: ink),
                  price: 50,
                  bg: cardBg,
                ),
                _StoreTile(
                  title: "Extend Garden",
                  icon: Icon(Icons.inventory_2_outlined, size: 30, color: ink),
                  price: 100,
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
                  bg: cardBg,
                ),
                _LockedTile(bg: lockedBg),
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
  const _ChipTile({required this.text, required this.bg, this.locked = false});
  final String text;
  final Color bg;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: cs.onSurface,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _WideTile extends StatelessWidget {
  const _WideTile({required this.title, required this.price, required this.bg});
  final String title;
  final int price;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
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
    );
  }
}

class _StoreTile extends StatelessWidget {
  const _StoreTile({
    required this.title,
    required this.icon,
    required this.price,
    required this.bg,
    this.onTap,
  });

  final String title;
  final Widget icon;
  final int price;
  final Color bg;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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
