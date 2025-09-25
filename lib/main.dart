// Archivo: lib/main.dart !

import 'package:flutter/material.dart';
import 'themetoggle.dart';
import 'langtoggle.dart';
import 'mainmenu.dart';
import 'drawer.dart';
import 'hero.dart';

void main() {
  runApp(const IgenCoreApp());
}

class IgenCoreApp extends StatefulWidget {
  const IgenCoreApp({super.key});

  @override
  State<IgenCoreApp> createState() => _IgenCoreAppState();
}

class _IgenCoreAppState extends State<IgenCoreApp> {
  late final ValueNotifier<ThemeMode> _themeMode;
  late final ValueNotifier<String> _language;

  @override
  void initState() {
    super.initState();
    _themeMode = ValueNotifier(ThemeMode.light);
    _language = ValueNotifier('ES');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final platformBrightness = MediaQuery.of(context).platformBrightness;
    _themeMode.value = platformBrightness == Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light;
  }
  
  @override
  void dispose() {
    _themeMode.dispose();
    _language.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeMode,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: 'iGenCore',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: themeMode,
          home: HomePage(
            themeModeNotifier: _themeMode,
            languageNotifier: _language,
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeModeNotifier;
  final ValueNotifier<String> languageNotifier;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({
    super.key,
    required this.themeModeNotifier,
    required this.languageNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    final isDarkMode = themeModeNotifier.value == ThemeMode.dark;
    final logoPath = isDarkMode
        ? 'assets/images/logoigenwhite.png'
        : 'assets/images/logoigenblack.png';
    
    final logoWidget = Image.asset(
      logoPath,
      height: 24,
    );
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: isDesktop
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ThemeToggle(themeModeNotifier: themeModeNotifier),
                      const SizedBox(width: 8),
                      logoWidget,
                    ],
                  ),
                  MainMenu(
                    languageNotifier: languageNotifier,
                  ),
                  LanguageToggle(languageNotifier: languageNotifier),
                ],
              )
            : Row(
                children: [
                  ThemeToggle(themeModeNotifier: themeModeNotifier),
                  const SizedBox(width: 8),
                  logoWidget,
                ],
              ),
        actions: isDesktop
            ? null
            : [
                LanguageToggle(languageNotifier: languageNotifier),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                ),
              ],
      ),
      endDrawer: isDesktop
          ? null
          : CustomDrawer(
              languageNotifier: languageNotifier,
              logoWidget: logoWidget,
              themeModeNotifier: themeModeNotifier,
            ),
      body: SingleChildScrollView(
        child: Center( // <-- Nuevo widget: Centra todo el contenido de la columna
          child: Column(
            children: [
              HeroSection(languageNotifier: languageNotifier),
              // Aquí irían los demás widgets del sitio, todos justificados al centro
            ],
          ),
        ),
      ),
    );
  }
}