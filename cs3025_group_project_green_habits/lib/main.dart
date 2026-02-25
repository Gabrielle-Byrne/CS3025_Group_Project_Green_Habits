import 'package:cs3025_group_project_green_habits/leaderboard.dart';
import 'package:cs3025_group_project_green_habits/state/points_store.dart';
import 'package:cs3025_group_project_green_habits/tips.dart';
import 'package:cs3025_group_project_green_habits/widgets/theme.dart';
import 'package:cs3025_group_project_green_habits/databases/preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'login.dart';
import 'signup.dart';
import 'garden.dart';
import 'activitylog.dart';
import 'profile.dart';
import 'plant_store.dart';
import 'state/challenge_store.dart';
import 'widgets/challenge_snackbar_listener.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String lang = await PreferencesService.getLanguage();
  bool darkMode = await PreferencesService.getDarkMode();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PointsStore()),
        ChangeNotifierProxyProvider<PointsStore, ChallengeStore>(
          create: (_) => ChallengeStore(),
          update: (_, points, challenges) {
            challenges!.attachPointsStore(points);
            return challenges;
          },
        ),
      ],
      child: MyApp(initialLang: lang, initialDarkMode: darkMode),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialLang;
  final bool initialDarkMode;

  const MyApp({
    super.key,
    required this.initialLang,
    required this.initialDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale(initialLang),
      title: 'Green Habits',
      theme: AppTheme.light(),
      supportedLocales: const [Locale('en'), Locale('fr')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: '/login',
      //darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/profile': (context) => ProfilePage(),

        '/garden': (context) => GardenPage(),
        '/plant_store': (context) => PlantStorePage(),

        '/activity-log': (context) => ActivityLogPage(),
        '/history': (context) => ActivityLogPage(),
        '/leaderboard': (context) => LeaderboardPage(),
        '/challenges': (context) => ActivityLogPage(),
        '/tips': (context) => TipsPage(),
      },
      builder: (context, child) {
        return ChallengeSnackBarListener(
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
