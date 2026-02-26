import 'package:cs3025_group_project_green_habits/leaderboard.dart';
import 'package:cs3025_group_project_green_habits/state/activity_log_store.dart';
import 'package:cs3025_group_project_green_habits/state/points_store.dart';
import 'package:cs3025_group_project_green_habits/state/settings_store.dart';
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
import 'history.dart';
import 'state/challenge_store.dart';
import 'widgets/challenge_snackbar_listener.dart';
import 'state/garden_store.dart';
import 'package:provider/provider.dart';
import 'state/auth_store.dart';
import 'widgets/require_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String lang = await PreferencesService.getLanguage();
  final bool darkMode = await PreferencesService.getDarkMode();

  final pointsStore = PointsStore();
  await pointsStore.init();

  final activityLogStore = ActivityLogStore();
  await activityLogStore.init();
  final double textScale = await PreferencesService.getTextScale();
  final bool soundEnabled = await PreferencesService.getSoundEnabled();
  final bool vibrationEnabled = await PreferencesService.getVibrationEnabled();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: pointsStore),
        ChangeNotifierProvider.value(value: activityLogStore),
        ChangeNotifierProvider(create: (_) => AuthStore()),
        ChangeNotifierProvider(create: (_) => GardenStore()),
        ChangeNotifierProvider(
          create: (_) => SettingsStore(
            initialLocale: Locale(lang),
            initialThemeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            initialTextScale: textScale,
            initialSound: soundEnabled,
            initialVibration: vibrationEnabled,
          ),
        ),
        ChangeNotifierProxyProvider<PointsStore, ChallengeStore>(
          create: (_) => ChallengeStore(),
          update: (_, points, challenges) {
            challenges!.attachPointsStore(points);
            return challenges;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsStore>();

    return MaterialApp(
      locale: settings.locale,
      title: 'Green Habits',
      theme: AppTheme.light(),
      supportedLocales: const [Locale('en'), Locale('fr')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: '/login',
      darkTheme: AppTheme.dark(),
      themeMode: settings.themeMode,
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),

        '/home': (context) => const RequireAuth(child: HomePage()),
        '/profile': (context) => const RequireAuth(child: ProfilePage()),

        '/garden': (context) => const RequireAuth(child: GardenPage()),
        '/plant_store': (context) => const RequireAuth(child: PlantStorePage()),

        '/activity-log': (context) =>
            const RequireAuth(child: ActivityLogPage()),
        '/history': (context) => const RequireAuth(child: HistoryPage()),
        '/leaderboard': (context) =>
            const RequireAuth(child: LeaderboardPage()),
        '/challenges': (context) => const RequireAuth(child: ActivityLogPage()),
        '/tips': (context) => const RequireAuth(child: TipsPage()),
      },
      builder: (context, child) {
        final mq = MediaQuery.of(context);
        return MediaQuery(
          data: mq.copyWith(textScaler: TextScaler.linear(settings.textScale)),
          child: ChallengeSnackBarListener(
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
