import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'databases/preferences.dart';
import 'state/settings_store.dart';
import 'widgets/bottomNavigationBar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Match the home/profile mock styling
  static const Color kBg = Color(0xFFFBFFFA);
  static const Color kDarkGreen = Color(0xFF084E18);
  static const Color kTipGreen = Color(0xFF1E6B2A);
  static const Color kPanelFill = Color(0xFFD6E4D6);
  static const Color kPanelBorder = Color(0xFFB8C8B8);

  String _username = 'User';
  String _email = 'user@email.com';
  String _password = 'password';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final u = await PreferencesService.getUsername();
    final e = await PreferencesService.getEmail();
    final p = await PreferencesService.getPassword();

    setState(() {
      _username = (u == null || u.trim().isEmpty) ? 'User' : u.trim();
      _email = (e == null || e.trim().isEmpty) ? 'user@email.com' : e.trim();
      _password = (p == null || p.isEmpty) ? 'password' : p;
    });
  }

  String _maskEmail(String email) {
    final at = email.indexOf('@');
    if (at <= 1) return email;
    final first = email.substring(0, 1);
    final domain = email.substring(at);
    return '$first*****$domain';
  }

  String _maskPassword(String password) {
    final len = password.isEmpty ? 8 : password.length;
    return List.filled(len.clamp(8, 14), '*').join();
  }

  Future<void> _maybeHaptic(BuildContext context) async {
    final settings = context.read<SettingsStore>();
    if (settings.vibrationEnabled) {
      await HapticFeedback.lightImpact();
    }
  }

  Future<void> _promptAndSave({
    required String title,
    required String initial,
    required Future<void> Function(String value) onSave,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
  }) async {
    final controller = TextEditingController(text: initial);
    final value = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, controller.text.trim()),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (value == null || value.isEmpty) return;
    await onSave(value);
    await _maybeHaptic(context);
  }

  Future<void> _openTextSizeSheet(SettingsStore settings) async {
    double temp = settings.textScale;

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Adjust Text Size',
                style: TextStyle(
                  color: Theme.of(ctx).colorScheme.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text('Current: ${settings.textSizeLabel}'),
              Slider(
                value: temp,
                min: 0.85,
                max: 1.35,
                divisions: 10,
                label: temp.toStringAsFixed(2),
                onChanged: (v) {
                  temp = v;
                  // Update live while sliding
                  settings.setTextScale(v);
                },
              ),
              const SizedBox(height: 6),
              const Text('Tip: 1.0 = default size'),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openLanguageSheet(SettingsStore settings) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                trailing: settings.locale.languageCode == 'en'
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  settings.setLanguageCode('en');
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                title: const Text('French'),
                trailing: settings.locale.languageCode == 'fr'
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  settings.setLanguageCode('fr');
                  Navigator.pop(ctx);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsStore>();
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final panelFill = isDark ? cs.secondaryContainer : kPanelFill;
    final panelBorder = isDark ? cs.primary.withOpacity(0.35) : kPanelBorder;

    return Scaffold(
      // Let the active theme control the background (so dark mode works).
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    'GREEN HABITS',
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
                      'Need\nTips?',
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        child: Column(
          children: [
            // Avatar + greeting
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFFCFE0CF),
                shape: BoxShape.circle,
                border: Border.all(color: panelBorder, width: 1),
              ),
              child: Icon(Icons.person, size: 44, color: cs.onSurface),
            ),
            const SizedBox(height: 10),
            Text(
              'Hello, $_username!',
              style: TextStyle(
                color: cs.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),

            // Two-column preference panel
            Container(
              decoration: BoxDecoration(
                color: panelFill,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: panelBorder, width: 1),
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Left: buttons
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                          children: [
                          _PrefButton(
                            text: 'Change Username',
                            onTap: () => _promptAndSave(
                              title: 'Change Username',
                              initial: _username,
                              onSave: (v) async {
                                await PreferencesService.setUsername(v);
                                setState(() => _username = v);
                              },
                            ),
                          ),
                          _PrefButton(
                            text: 'Change Email',
                            onTap: () => _promptAndSave(
                              title: 'Change Email',
                              initial: _email,
                              keyboardType: TextInputType.emailAddress,
                              onSave: (v) async {
                                await PreferencesService.setEmail(v);
                                setState(() => _email = v);
                              },
                            ),
                          ),
                          _PrefButton(
                            text: 'Change Password',
                            onTap: () => _promptAndSave(
                              title: 'Change Password',
                              initial: '',
                              obscure: true,
                              onSave: (v) async {
                                await PreferencesService.setPassword(v);
                                setState(() => _password = v);
                              },
                            ),
                          ),
                          _PrefButton(
                            text: 'Adjust Text Size',
                            onTap: () => _openTextSizeSheet(settings),
                          ),
                          _PrefButton(
                            text: 'Switch Light/Dark\nMode',
                            onTap: () => settings.toggleThemeMode(),
                          ),
                          _PrefButton(
                            text: 'Change Language',
                            onTap: () => _openLanguageSheet(settings),
                          ),
                          _PrefButton(
                            text: 'Vibrations',
                            onTap: () => settings.toggleVibration(),
                          ),
                          _PrefButton(
                            text: 'Sounds',
                            onTap: () => settings.toggleSound(),
                          ),
                          ],
                        ),
                      ),
                    ),

                    VerticalDivider(
                      width: 2,
                      thickness: 2,
                      color: cs.primary,
                    ),

                    // Right: values
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                          children: [
                            _ValueText(_username),
                            _ValueText(_maskEmail(_email)),
                            _ValueText(_maskPassword(_password)),
                            _ValueText(settings.textSizeLabel),
                            _ValueText(settings.themeLabel),
                            _ValueText(settings.languageLabel),
                            _ValueText(
                              settings.vibrationEnabled ? 'Enabled' : 'Disabled',
                            ),
                            _ValueText(settings.soundEnabled ? 'Enabled' : 'Disabled'),
                          ],
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

      bottomNavigationBar: const BottomNavigation(currentRoute: '/profile'),
    );
  }
}

class _PrefButton extends StatelessWidget {
  const _PrefButton({required this.text, required this.onTap});

  static const Color kDarkGreen = Color(0xFF084E18);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 38,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkGreen,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 1.05,
            ),
          ),
        ),
      ),
    );
  }
}

class _ValueText extends StatelessWidget {
  const _ValueText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 38,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
