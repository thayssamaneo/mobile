import 'package:exemplo_shared_preferences/view/exemplo1_page.dart';
import 'package:exemplo_shared_preferences/view/exemplo2_page.dart';
import 'package:exemplo_shared_preferences/view/exemplo3_page.dart';
import 'package:exemplo_shared_preferences/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // pega o valor salvo no SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  bool darkMode = prefs.getBool("darkMode") ?? false;

  runApp(MyApp(initialDarkMode: darkMode));
}

class MyApp extends StatefulWidget {
  final bool initialDarkMode;

  const MyApp({super.key, required this.initialDarkMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void _updateThemeMode(bool isDarkMode) {
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo Shared Preferences',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      routes: {
        '/tela1': (context) => const Exemplo1Page(),
        '/tela2': (context) => Exemplo2Page(
          initialDarkMode: _themeMode == ThemeMode.dark,
          onThemeChanged: _updateThemeMode,
        ),
        '/tela3': (context) => const Exemplo3Page(),
      },
      home: const HomePage(),
    );
  }
}
