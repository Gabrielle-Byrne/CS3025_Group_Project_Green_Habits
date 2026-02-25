import 'package:flutter/material.dart';
import 'widgets/bottomNavigationBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color kBg = Color(0xFFFBFFFA);
  static const Color kDarkGreen = Color(0xFF084E18);
  static const Color kTipGreen = Color(0xFF1E6B2A);
  static const Color kPanelFill = Color(0xFFD6E4D6);
  static const Color kPanelBorder = Color(0xFFB8C8B8);
  static const Color kNavSelectedPill = Color(0xFFB8C8B8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: SafeArea(
          bottom: false,
          child: Container(
            height: 56,
            color: kDarkGreen,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.park, color: Colors.white, size: 28),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    "GREEN HABITS",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                SizedBox(
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/tips'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kTipGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Need\nTips?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        height: 1.05,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // ✅ No scrollview — lets us use Expanded to fill the screen nicely
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

            // ✅ This grows to fill leftover space (removes bottom gaps)
            Expanded(
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/garden'),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kPanelFill,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: kPanelBorder, width: 1),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Quick-Log Action Bar",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: kDarkGreen,
              ),
            ),
            const SizedBox(height: 8),

            // ✅ Use Expanded so spacing is even
            Row(
              children: const [
                Expanded(child: _QuickAction(label: "Quick Action\n1")),
                Expanded(child: _QuickAction(label: "Quick Action\n2")),
                Expanded(child: _QuickAction(label: "Quick Action\n3")),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: const [
                Expanded(
                  child: Center(
                    child: Text(
                      "Community",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: kDarkGreen,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Rewards",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: kDarkGreen,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Bottom cards (fixed height works well now because garden is flexible)
            SizedBox(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kPanelFill,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: kPanelBorder, width: 1),
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
                                backgroundColor: kNavSelectedPill,
                                foregroundColor: kDarkGreen,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text(
                                "Leaderboard",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "1.  Tom Smith\n2.  Jane Doe\n3.  Dan Pearce",
                            style: TextStyle(
                              color: kDarkGreen,
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
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kPanelFill,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: kPanelBorder, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: const SizedBox(
                              height: 14,
                              width: double.infinity,
                              child: LinearProgressIndicator(
                                value: 0.8,
                                backgroundColor: Color(0xFFCFE0CF),
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(kDarkGreen),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              "100 points left to collect\nthis reward",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kDarkGreen,
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
                                  Navigator.pushNamed(context, '/history'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kDarkGreen,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text(
                                "View Past Actions",
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

      bottomNavigationBar: const BottomNavigation(currentRoute: "/home"),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String label;
  const _QuickAction({required this.label});

  static const Color kDarkGreen = Color(0xFF084E18);
  static const Color kCircleFill = Color(0xFFCFE0CF);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 74,
          height: 74,
          decoration: const BoxDecoration(
            color: kCircleFill,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: kDarkGreen,
            fontWeight: FontWeight.w700,
            fontSize: 11,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}