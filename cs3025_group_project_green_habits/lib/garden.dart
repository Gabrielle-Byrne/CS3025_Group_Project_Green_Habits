import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/bottomNavigationBar.dart';
import 'package:provider/provider.dart';
import 'state/points_store.dart';

class GardenPage extends StatefulWidget {
  const GardenPage({super.key});
  @override
  State<GardenPage> createState() => _GardenPageState();
}

class _GardenPageState extends State<GardenPage> {
   static const Color kBg = Color(0xFFFBFFFA);
  static const Color kDarkGreen = Color(0xFF084E18);
  static const Color kGardenFill = Color(0xFFD6E4D6); // light green panel
  static const Color kGardenBorder = Color(0xFFB8C8B8);
  @override
  Widget build(BuildContext context) {
    final points = context.watch<PointsStore>().points;
    return Scaffold(
      backgroundColor: kBg,
      appBar: const HeaderBar(
        title: "GREEN HABITS",
        helpText:
            "This is your garden. You can use points earned from your actions to purchase virtual plants.",
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Virtual Garden",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: kDarkGreen,
              ),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kGardenFill,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kGardenBorder, width: 1),
                ),
                // Garden Items
                child: const SizedBox.shrink(),
              ),
            ),

            const SizedBox(height: 12),

            // Plant Store button
            SizedBox(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/plant_store');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkGreen,
                  foregroundColor: Colors.white,
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
