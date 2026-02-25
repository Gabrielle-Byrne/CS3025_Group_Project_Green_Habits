import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'package:provider/provider.dart';
import 'state/points_store.dart';

class PlantStorePage extends StatelessWidget {
  const PlantStorePage({super.key});

  static const Color kBg = Color(0xFFFBFFFA);
  static const Color kDarkGreen = Color(0xFF084E18);
  static const Color kCard = Color(0xFFCCDDCF);
  static const Color kSelected = Color(0xFF85A98D);

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
    final points = context.watch<PointsStore>().points;

    return Scaffold(
      backgroundColor: kBg,
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
            // Top row: Plant Store + points
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Plant Store",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: kDarkGreen,
                  ),
                ),
                _PointsDisplay(points: points),
              ],
            ),
            const SizedBox(height: 10),

            // Mystery Seed tile (clickable)
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 110,
                child: _StoreTile(
                  title: "Mystery Seed",
                  icon: const _DropIcon(),
                  price: 50,
                  onTap: () => _buy(context, "Mystery Seed", 50),
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
                  icon: const _TripleDropIcon(),
                  price: 50,
                  onTap: () => _buy(context, "Self Watering Pot", 50),
                ),
                _StoreTile(
                  title: "Extend Garden",
                  icon: const _PotIcon(),
                  price: 100,
                  onTap: () => _buy(context, "Extend Garden", 100),
                ),
                _StoreTile(
                  title: "Power Up 3",
                  icon: const Icon(Icons.shopping_cart_outlined,
                      size: 30, color: kDarkGreen),
                  price: 150,
                  onTap: () => _buy(context, "Power Up 3", 150),
                ),
                _StoreTile(
                  title: "Power Up 4",
                  icon: const Icon(Icons.shopping_cart_outlined,
                      size: 30, color: kDarkGreen),
                  price: 150,
                  onTap: () => _buy(context, "Power Up 4", 150),
                ),
                _StoreTile(
                  title: "Power Up 5",
                  icon: const Icon(Icons.shopping_cart_outlined,
                      size: 30, color: kDarkGreen),
                  price: 150,
                  onTap: () => _buy(context, "Power Up 5", 150),
                ),
                const _LockedTile(
                  text: "Locked\nComplete\nChallenge to\nUnlock Power-\nUp",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------- Small UI widgets below ---------- */

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  static const Color kDarkGreen = Color(0xFF084E18);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w800,
        color: kDarkGreen,
      ),
    );
  }
}

class _PointsDisplay extends StatelessWidget {
  const _PointsDisplay({required this.points});
  final int points;

  static const Color kDarkGreen = Color(0xFF084E18);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 8, color: kDarkGreen),
        const SizedBox(width: 6),
        Text(
          "$points",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: kDarkGreen,
          ),
        ),
      ],
    );
  }
}

class _ChipTile extends StatelessWidget {
  const _ChipTile({
    required this.text,
    this.locked = false,
    this.price,
    this.onTap,
  });

  final String text;
  final bool locked;
  final int? price;
  final VoidCallback? onTap;

  static const Color kCard = Color(0xFFCCDDCF);
  static const Color kSelected = Color(0xFF85A98D);
  static const Color kDarkGreen = Color(0xFF084E18);

  @override
  Widget build(BuildContext context) {
    final enabled = !locked && onTap != null;

    return Material(
      color: locked ? kSelected : kCard,
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
                style: const TextStyle(
                  color: kDarkGreen,
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
  });

  final String title;
  final int price;
  final VoidCallback? onTap;

  static const Color kCard = Color(0xFFCCDDCF);
  static const Color kDarkGreen = Color(0xFF084E18);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kCard,
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
                style: const TextStyle(
                  color: kDarkGreen,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
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
  });

  final String title;
  final Widget icon;
  final int price;
  final VoidCallback? onTap;

  static const Color kCard = Color(0xFFCCDDCF);
  static const Color kDarkGreen = Color(0xFF084E18);

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
      ),
    );
  }
}

class _LockedTile extends StatelessWidget {
  const _LockedTile({required this.text});
  final String text;

  static const Color kSelected = Color(0xFF85A98D);
  static const Color kDarkGreen = Color(0xFF084E18);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: kSelected,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.lock_outline, size: 28, color: kDarkGreen),
          SizedBox(height: 8),
          Expanded(
            child: Center(
              child: Text(
                "Locked\nComplete\nChallenge to\nUnlock Power-\nUp",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDarkGreen,
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

/* Icons */
class _DropIcon extends StatelessWidget {
  const _DropIcon();

  static const Color kDarkGreen = Color(0xFF084E18);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.water_drop_outlined, size: 30, color: kDarkGreen);
  }
}

class _TripleDropIcon extends StatelessWidget {
  const _TripleDropIcon();

  static const Color kDarkGreen = Color(0xFF084E18);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.water_drop_outlined, size: 18, color: kDarkGreen),
        SizedBox(width: 4),
        Icon(Icons.water_drop_outlined, size: 18, color: kDarkGreen),
        SizedBox(width: 4),
        Icon(Icons.water_drop_outlined, size: 18, color: kDarkGreen),
      ],
    );
  }
}

class _PotIcon extends StatelessWidget {
  const _PotIcon();

  static const Color kDarkGreen = Color(0xFF084E18);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.inventory_2_outlined, size: 30, color: kDarkGreen);
  }
}