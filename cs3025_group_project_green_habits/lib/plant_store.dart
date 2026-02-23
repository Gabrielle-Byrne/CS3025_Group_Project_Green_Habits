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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,

      // Same header style, but with Previous
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
                _PointsDisplay(points: context.watch<PointsStore>().points),              ],
            ),
            const SizedBox(height: 10),

            // Mystery Seed tile (left aligned)
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 110,
                child: _StoreTile(
                  title: "Mystery Seed",
                  icon: _DropIcon(),
                  price: 50,
                ),
              ),
            ),

            const SizedBox(height: 14),

            const _SectionTitle("Seed Packs"),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                _ChipTile(text: "Common Plants"),
                _ChipTile(text: "Rare Flowers"),
                _ChipTile(text: "Elm Tree\nLocked", locked: true),
              ],
            ),

            const SizedBox(height: 14),

            const _SectionTitle("Gift a Friend"),
            const SizedBox(height: 8),
            const _WideTile(title: "Gift a Plant", price: 50),

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
              children: const [
                _StoreTile(
                  title: "Self Watering\nPot",
                  icon: _TripleDropIcon(),
                  price: 50,
                ),
                _StoreTile(
                  title: "Extend Garden",
                  icon: _PotIcon(),
                  price: 100,
                ),
                _StoreTile(
                  title: "Power Up 3",
                  icon: Icon(Icons.shopping_cart_outlined,
                      size: 30, color: kDarkGreen),
                  price: 150,
                ),
                _StoreTile(
                  title: "Power Up 4",
                  icon: Icon(Icons.shopping_cart_outlined,
                      size: 30, color: kDarkGreen),
                  price: 150,
                ),
                _StoreTile(
                  title: "Power Up 5",
                  icon: Icon(Icons.shopping_cart_outlined,
                      size: 30, color: kDarkGreen),
                  price: 150,
                ),
                _LockedTile(
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
  const _ChipTile({required this.text, this.locked = false});
  final String text;
  final bool locked;

  static const Color kCard = Color(0xFFCCDDCF);
  static const Color kSelected = Color(0xFF85A98D);
  static const Color kDarkGreen = Color(0xFF084E18);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: locked ? kSelected : kCard,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: kDarkGreen,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _WideTile extends StatelessWidget {
  const _WideTile({required this.title, required this.price});
  final String title;
  final int price;

  static const Color kCard = Color(0xFFCCDDCF);
  static const Color kDarkGreen = Color(0xFF084E18);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(6),
      ),
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
    );
  }
}

class _StoreTile extends StatelessWidget {
  const _StoreTile({
    required this.title,
    required this.icon,
    required this.price,
  });

  final String title;
  final Widget icon;
  final int price;

  static const Color kCard = Color(0xFFCCDDCF);
  static const Color kDarkGreen = Color(0xFF084E18);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(6),
      ),
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